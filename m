Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E17CDE008
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 11:18:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BA8C10F092;
	Thu, 25 Jun 2026 11:18:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="fSk1vHv9";
	dkim-atps=neutral
X-Greylist: delayed 305 seconds by postgrey-1.36 at gabe;
 Thu, 25 Jun 2026 11:18:16 UTC
Received: from mail-m822136196.xmail.ntesmail.com
 (mail-m822136196.xmail.ntesmail.com [8.221.36.196])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DE4A10F092;
 Thu, 25 Jun 2026 11:18:15 +0000 (UTC)
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
 by smtp.qiye.163.com (Hmail) with ESMTP id 43c0dec8c;
 Thu, 25 Jun 2026 19:13:06 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: dakr@kernel.org
Cc: dawei.feng@seu.edu.cn, dri-devel@lists.freedesktop.org,
 jianhao.xu@seu.edu.cn, linux-kernel@vger.kernel.org, lyude@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, simona@ffwll.ch, stable@vger.kernel.org,
 ttabi@nvidia.com, zilin@seu.edu.cn
Subject: Re: [PATCH v2] nouveau/firmware: fix memory leak on BL load failure
Date: Thu, 25 Jun 2026 19:13:08 +0800
Message-Id: <20260625111308.1407104-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <DJEQTPJAR8DW.18CJ2FC7YZPA3@kernel.org>
References: <DJEQTPJAR8DW.18CJ2FC7YZPA3@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9efe7bca7e03a2kunm68fb4ad27cf8c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTh8ZVkhOSkNJHh5MHx9PGlYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
 9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
 b=fSk1vHv9g3pkECkmoJLMWQpP7Xj+htLFoPA1G1aP7jF4T3/oyBYsDZsd8jGPulrd3v9QhMl3Jsw4r6g4mQU+diQ/YXv0tmhKDCQSUPxZExB09QCHnvMnXGzFgzjBXzM9Ysh86D/uhko8GNwKn4JxXMp8f4uxGRkr09uNua4ko+o=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=Bxv0WhQiYf6pkXwOGd8BAHkpkzQ7RlMAJ6ktjf5RQ60=;
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

Hi,Danilo,

Thanks for the review.

On Sun, 21 Jun 2026 14:57:56 +0200, Danilo Krummrich wrote:
>> Fixes: 2541626cfb79 ("drm/nouveau/acr: use common falcon HS FW code for ACR FWs")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
>
>Is Zilin a co-author of the patch?
 
Zilin is the discoverer of this bug. We are in the same research group,
and he actively participated in reviewing this patch. 

Should I set Zilin as Reported-by in the v3 patch?

Best regards,
Dawei Feng
