Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63EFC43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 03:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54BEA10E551;
	Sun, 28 Jun 2026 03:52:21 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDB8110E551
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 03:52:19 +0000 (UTC)
Received: from smtpclient.apple (unknown [117.182.74.7])
 by APP-01 (Coremail) with SMTP id qwCowAA33NRbmkBqExKqAw--.34181S3;
 Sun, 28 Jun 2026 11:52:16 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: accel/habanalabs:
 hl_cs_signal_sob_wraparound_handler: missing   hw_sob_get when need_reset is
 true and encaps_sig is false
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626104453.32301-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 11:52:05 +0800
Cc: kees@kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <20710ACB-AEAB-473B-A9E5-EE3116A46ACB@iscas.ac.cn>
References: <20260626104453.32301-1-vulab@iscas.ac.cn>
To: koby.elbaz@intel.com,
 konstantin.sinyuk@intel.com,
 ogabbay@kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID: qwCowAA33NRbmkBqExKqAw--.34181S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4UZrWUCFWkArWxKr18AFb_yoW8Ar1kpa
 s8GF4rJF9xXF9rAF12kw45ZFyrW398KryDua1xG395urn8Ga4xJ34Y9anY9rWUurs3WF48
 XF9FqayDC3Z0ya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBqb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
 64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcV
 CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv
 6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
 Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
 6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw2
 8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
 x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrw
 CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
 42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
 80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU07rc3UUUUU==
X-Originating-IP: [117.182.74.7]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwcMA2pAixEZHQAAs7
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



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 18:44=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> When other_sob->need_reset is true and encaps_sig is false,
>  hw_sob_put(other_sob) decrements the kref to 0, but the matching
>  hw_sob_get(other_sob) is skipped because it is inside the encaps_sig
>  block. The function returns other_sob with kref=3D0, causing a =
subsequent
>  kref_put to underflow. Fix by adding hw_sob_get(other_sob) in the =
else
>  branch.
>=20
> Cc: stable@vger.kernel.org
> Fixes: dadf17abb724 ("habanalabs: add support for encapsulated signals =
reservation")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/accel/habanalabs/common/command_submission.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/accel/habanalabs/common/command_submission.c =
b/drivers/accel/habanalabs/common/command_submission.c
> index ba4257bda77b..675301dfc0ef 100644
> --- a/drivers/accel/habanalabs/common/command_submission.c
> +++ b/drivers/accel/habanalabs/common/command_submission.c
> @@ -1860,11 +1860,10 @@ int hl_cs_signal_sob_wraparound_handler(struct =
hl_device *hdev, u32 q_idx,
> 		if (other_sob->need_reset)
> 			hw_sob_put(other_sob);
>=20
> -		if (encaps_sig) {
> +		if (encaps_sig)
> 			/* set reset indication for the sob */
> 			sob->need_reset =3D true;
> -			hw_sob_get(other_sob);
> -		}
> +		hw_sob_get(other_sob);
>=20
> 		dev_dbg(hdev->dev, "switched to SOB %d, q_idx: %d\n",
> 				prop->curr_sob_offset, q_idx);
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang=

