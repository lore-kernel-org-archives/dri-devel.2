Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B41C624D7
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9EAA10F3E7;
	Thu,  3 Sep 2026 07:33:27 +0000 (UTC)
X-Greylist: delayed 3791 seconds by postgrey-1.36 at gabe;
 Tue, 01 Sep 2026 07:36:48 UTC
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE1AB10EBA4;
 Tue,  1 Sep 2026 07:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
 s=iohv2404; t=1788248190;
 bh=FMXo3bO0qzDar0vxsQSKX+ThzBkt5waPMvBBuUNS/kU=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=pnEgrGqlEvF+6V+Pd7dtaSDoI3ZJne8wtxaoL3eCRF+dzFyymiMUTVyNi8TYOIRj0
 LeAa9o5krlaa0Lqm0H212kurLx6IrRF0WQ9cl4ipJZwiDk1voeQruDDFZi5wPBfs6o
 wQWvuk7aVo8m7reJTC/3y2Mx7k3KlwizY7ZT/mB8=
X-QQ-mid: esmtpgz10t1788248185t673dc2ed
X-QQ-Originating-IP: qDq27hcP+Rp8Psic93OtsDSkMg4ZsjrcuvjY1CFJKmY=
Received: from [127.0.0.1] ( [180.98.43.87]) by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 01 Sep 2026 15:36:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11605117471512466628
Message-ID: <92098CDF3B76D648+da81354b-56cd-4b07-9e5a-acdf4d730478@smail.nju.edu.cn>
Date: Tue, 1 Sep 2026 15:36:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau/uvmm: fix UAF in bind job cleanup
To: lyude@redhat.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <7F26D29D0BD60619+20260901063255.661503-1-peiyang_he@smail.nju.edu.cn>
Content-Language: en-US
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
In-Reply-To: <7F26D29D0BD60619+20260901063255.661503-1-peiyang_he@smail.nju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NEAuM+RWOyST1V/S32fS9NZTyEBnm2dFxf60mAYkg9tztHHA6rfqPR5d
 DmS3sAsae7BU2M1HnwAJpZFOPyyMZOF6lEykgqelaygwYkHLwT0c1LnY3f3to7tA7Stg58h
 DyLubNofuXveNHWr0BV0hRd1Cvsvu5Hfpmro6wsN0CFVOLss0ZPqwClXgrjaF/KP7Rog9FQ
 KoXPYejwKD7mEgV9b4ryTyneS5qDJUF19DYjCNLycjjjLdphzUuSo47zeHqVJ7fyjjK17vJ
 EJA6i4AAjSc/lRLCn4/t76t66yVIK2ARvw4+RslIPlAobTkbMwGA9/RQQ03kXeDdXmUds+1
 bdYyHpSx6oefZuiR/Oglbh5FYQvN9k3Hfb9ojpyhyKb1BFqJfXMnCWKt1qyR30iV/QNoc9z
 nEqp2P5mt9EaS40dJy9HaAPcQSFG4cNHe0KBmd6fKFcOP/ucWnk5em+vRbDfNxRvMd2Tzn6
 1mF/uz3TGSvo3MjprhHLmsW52Y+TOrL3MHaebJ1z2ilfrppgsZ4FDEO4vjWYFr8ieskF2yJ
 paMKBPV66seh3JqXQeca3ZIbr8XsWuo2/KnYj/u4D+95ukH4qQy9X+2RE7zYZi21jxIjXtJ
 cyd2Ht/STszp/tQer6ZC1v4RaTERYR0JQcaehdOk+elJvLolLtm41NBztdfK34eFyJesB1u
 /dJSv+XZk7Yh+Roz5URcwlCy+QEmM5lLOtQXzIaoMaLzlEiqai0NFsAp4HNxv6G7oqwlv6S
 AGWAeCa3B5hF2OrDjDM9tpdbwZqE4lc3gdLuPicZYuNLob7N14BU1oo9KyvBpzaRTuuww4x
 gL7B2YjKWnj5hI7zDq0Bn0Z227nNc/xBX1o6MycgRiWp/Yco0dDpO7C37oOgijEE6K4RjXH
 uBTKwoeZTHQd7n5xeTXYU+Jx+yLzOXTuEmMntQoDU/pIhG4OwN7GkUT301M8URV3skFEm/a
 OVvQRrL/ZATH+9qwBTesd4p8e6iDWpry7OV7rAV+sA6I/vxlbcz66vWwgZN/zE6+37TUCoX
 /JrDnmwl0XaDPE1dXNUq347EMX28UuD7MIRZythR3/hzASHtGl
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

On 2026/9/1 14:32, Peiyang He wrote:
>  drivers/gpu/drm/nouveau/nouveau_uvmm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> index f5e4756b4de4..aad14316cbef 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> @@ -1318,6 +1318,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job,
>  			op->reg = nouveau_uvma_region_find(uvmm, op->va.addr,
>  							   op->va.range);
>  			if (!op->reg || op->reg->dirty) {
> +				op->reg = NULL;
>  				ret = -ENOENT;
>  				goto unwind_continue;
>  			}
> @@ -1327,6 +1328,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job,
>  								op->va.range);
>  			if (IS_ERR(op->ops)) {
>  				ret = PTR_ERR(op->ops);
> +				op->reg = NULL;
>  				goto unwind_continue;
>  			}

None of the two issues pointed by Sashiko AI are introduced by this patch.
