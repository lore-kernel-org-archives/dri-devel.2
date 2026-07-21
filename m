Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B70CC44537
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 22:11:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4476510EBA4;
	Tue, 21 Jul 2026 22:11:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="RSA7vHXF";
	dkim-atps=neutral
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net
 (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8BED610E2E1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 07:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stu.xidian.edu.cn; s=dkim; h=Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type:Content-Transfer-Encoding; bh=x1IfwcVqk
 fyOpOyA4DHLIUh0/8VZmvUDXiClmKl43L4=; b=RSA7vHXFX7TDb5y923TfOGAgA
 +zoFTJgb0u62AF/aNa2fiSrhStWtK/dYqTFNvn3lPGlxKusIJmj5mr5SuKzHa8CD
 pvDnmEpAl4JJsn2iIXmmGRNazhh1qCZlE2MW+5fl+UQkZXhIEto0W5veBk5UsqOQ
 fWi5S1Vqf+Zh77DWUE=
Received: from [192.168.1.109] (unknown [115.53.183.71])
 by hzbj-edu-front-2.icoremail.net (Coremail) with SMTP id
 BLQMCkD2OjArJF9qr+lJAQ--.8878S3; 
 Tue, 21 Jul 2026 15:47:56 +0800 (CST)
Message-ID: <c8f95a3c-7c4f-4ffd-8bb3-f50b1cad4502@stu.xidian.edu.cn>
Date: Tue, 21 Jul 2026 15:47:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fbdev: core: Clamp total_size to smem_len in
 read/write functions
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260721071522.106306-1-25181214217@stu.xidian.edu.cn>
 <20260721073109.81A121F000E9@smtp.kernel.org>
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
In-Reply-To: <20260721073109.81A121F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: BLQMCkD2OjArJF9qr+lJAQ--.8878S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZw13Wr45tFW3GF1UtF4Dtwb_yoW3XFb_W3
 4rt3y2kF1UJr4Ivan5Ja1agrsI9F48ur18XryYyF43Jr98ZrW7JrZF9rnxWa4kA3ZxZ3Wr
 Jwnxu3yUCw129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbxAYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
 j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr
 4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY
 02Avz4vE14v_GF4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
 Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y
 6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
 kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
 xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07
 jzYLkUUUUU=
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAQUAEWpeO+sJ8gADsJ
X-Mailman-Approved-At: Tue, 21 Jul 2026 22:11:24 +0000
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


> Pre-existing issues:
> - [High] Partial copy to user space in `fb_io_read` causes silent skipping of framebuffer data and loop state desynchronization, leading to out-of-bounds I/O reads.
> - [High] Missing locking in fb_io and fb_sys operations allows concurrent mode switches to cause Use-After-Free and Out-Of-Bounds accesses.
> --


Thank you for the review.  Both issues are pre-existing in the current
code and are not introduced by this patch.  This patch only adds a
clamp on total_size as a hardening measure to prevent OOB accesses
caused by drivers that misreport screen_size.  It does not alter the
existing copy loop or locking model.

If desired, I can look into fixing the reported issues in separate
patches.

Thanks,
Mingyu

