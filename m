Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6415CD8CA7
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0888910E033;
	Tue,  9 Jun 2026 08:57:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="AD7+HCMt";
	dkim-atps=neutral
Received: from mail-m1064.netease.com (mail-m1064.netease.com [154.81.10.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7116D10E033;
 Tue,  9 Jun 2026 08:57:30 +0000 (UTC)
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
 by smtp.qiye.163.com (Hmail) with ESMTP id 41a876c6e;
 Tue, 9 Jun 2026 16:57:26 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: ttabi@nvidia.com
Cc: dakr@kernel.org, dawei.feng@seu.edu.cn, dri-devel@lists.freedesktop.org,
 jianhao.xu@seu.edu.cn, linux-kernel@vger.kernel.org, lyude@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 namcao@linutronix.de, nouveau@lists.freedesktop.org, simona@ffwll.ch,
 stable@vger.kernel.org, zilin@seu.edu.cn
Subject: Re: [PATCH] nouveau/firmware: fix memory leak on BL load failure
Date: Tue,  9 Jun 2026 16:57:29 +0800
Message-Id: <20260609085729.3786763-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0045b3583272df0b82f146fd96dee13d03377b4a.camel@nvidia.com>
References: <0045b3583272df0b82f146fd96dee13d03377b4a.camel@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9eab99d60503a2kunmd4cb5e84127d3d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGEtCVk4YSklJSh9MHh1JGlYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
 9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
 b=AD7+HCMty0xT7ukJ2iVq24XZZtBk3S/QiDWX6gpGVFjcPKiO7RmZE7dzKCP/i1ObA/sHrur+vKJnntauTebn7UK4kaZhgSBnpvDaCOC3pG1hOrsw5Ok03Ux6gPVAd2HoLcW8JJIC4/n1uvVMkY4LrxLMkFVDeukP++uXZW+UT0U=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=PWKiJfHLAuY51AfkQhZeCWOGsOm5BCLCBnZ0+m/OIxk=;
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

Hi, Timur,

On Fri, Jun 05, 2026 at 06:22:41PM +0000, Timur Tabi wrote:
> Ah yes, you're right.
>
> So now I think a better fix might be to have two different `blob`
> variables, so that there is no longer any confusion. Because right now,
> the nvkm_firmware_put() call at the end of the function releases a
> different `blob` depending on whether `bl` is NULL or not.
>
> What do you think about this:
>
>     nvkm_firmware_put(blob);
>     if (bl) {
>             const struct firmware *blob_bl;
>
>             ret = nvkm_firmware_load_name(subdev, bl, "", ver, &blob_bl);
>             if (ret)
>                     goto done;
>             ...
>             nvkm_firmware_put(blob_bl);
>             if (!fw->boot)
>                     ret = -ENOMEM;
>     } else {
>             fw->boot_addr = fw->nmem_base;
>     }
>
> done:
>     if (ret)
>             nvkm_falcon_fw_dtor(fw);
>
>     return ret;

Yes, using a separate pointer `blob_bl` for the bootloader firmware is a
cleaner approach. 

However, we must keep the final nvkm_firmware_put(blob) under the done
label. Moving it earlier would cause memory leaks in prior error paths
like nvkm_falcon_fw_ctor(), which jump directly to done. 

A safer approach is to manage blob_bl locally inside the if (bl) block,
while leaving the original blob cleanup at the end. 

What do you think about this:

        if (bl) {
                const struct firmware *blob_bl;

                ret = nvkm_firmware_load_name(subdev, bl, "", ver, &blob_bl);
                if (ret)
                        goto done;

                ...
                nvkm_firmware_put(blob_bl);
                if (!fw->boot)
                        ret = -ENOMEM;
        } else {
                fw->boot_addr = fw->nmem_base;
        }

done:
        if (ret)
                nvkm_falcon_fw_dtor(fw);

        nvkm_firmware_put(blob);
        return ret;

Regards,
Dawei
