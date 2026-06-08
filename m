Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B9BCD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96B5C10F40C;
	Mon,  8 Jun 2026 13:57:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="mSUBhBoh";
	dkim-atps=neutral
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Mon, 08 Jun 2026 13:57:24 UTC
Received: from mail-m10230.netease.com (mail-m10230.netease.com
 [154.81.10.230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F5C810F40C;
 Mon,  8 Jun 2026 13:57:23 +0000 (UTC)
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
 by smtp.qiye.163.com (Hmail) with ESMTP id 418697a0a;
 Mon, 8 Jun 2026 21:52:17 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: ttabi@nvidia.com
Cc: dakr@kernel.org, dawei.feng@seu.edu.cn, dri-devel@lists.freedesktop.org,
 jianhao.xu@seu.edu.cn, linux-kernel@vger.kernel.org, lyude@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 namcao@linutronix.de, nouveau@lists.freedesktop.org, simona@ffwll.ch,
 stable@vger.kernel.org, zilin@seu.edu.cn
Subject: Re: [PATCH] nouveau/firmware: fix memory leak on BL load failure
Date: Mon,  8 Jun 2026 21:52:18 +0800
Message-Id: <20260608135218.3413471-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aa2e39a828634f20852d066f593f26510fbdc2d9.camel@nvidia.com>
References: <aa2e39a828634f20852d066f593f26510fbdc2d9.camel@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ea7816a8a03a2kunm10e519bdf5324
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTk5JVhpJS0lPGkkaT0NDTVYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
 5MTlVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
 b=mSUBhBoh0496xG4IiMYv5fe7It4OxD9eTPVOkNlmdB4vm520ELI4bYLj9R/YziGnOA7drsT3LqfYmPOjmRkbMJhKYoGBKqtDLXlWUPp9ktE+vZsjFQRIgsJGS79ZnfDIAxg2lMUGCv3s3wkryPG5OOUZJvv/6CxUIZjLG0kTwuI=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=PUAzZqFOE1r8m01APLHVgv/zFAIdkEgJl07BOOwnD+Q=;
 h=date:mime-version:subject:message-id:from;
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Timur,

On Fri, Jun 05, 2026 at 06:22:41PM +0000, Timur Tabi wrote:
> I think it would be cleaner to instead delete this
> nvkm_firmware_put(blob) call here, and just rely on the call to
> nvkm_firmware_put() at the end of nvkm_falcon_fw_ctor_hs(). Then you
> won't need "blob = NULL".

Thanks for your review.

I don't think we can drop the nvkm_firmware_put(blob) here. At this
point, blob still points to the image firmware loaded at the beginning of
nvkm_falcon_fw_ctor_hs(). The later nvkm_firmware_load_name(..., &blob)
call overwrites blob with the bootloader firmware pointer on success.

If we only rely on the final nvkm_firmware_put(blob), the success path
would release the bootloader firmware, but the original image firmware
pointer would be lost and leaked.

Best regards,
Dawei
