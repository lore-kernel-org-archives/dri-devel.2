Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FC6C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 03:55:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92D6010E55C;
	Sun, 28 Jun 2026 03:55:35 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 657FD10E55C;
 Sun, 28 Jun 2026 03:55:33 +0000 (UTC)
Received: from smtpclient.apple (unknown [117.182.74.7])
 by APP-01 (Coremail) with SMTP id qwCowADXfdYKm0BqqCuqAw--.7249S5;
 Sun, 28 Jun 2026 11:55:26 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: drm/i915: __live_active_setup: kfree bypasses
 kref_put in early   error path
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626132252.38377-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 11:55:15 +0800
Cc: christian.koenig@amd.com, kees@kernel.org, tzimmermann@suse.de,
 matthew.brost@intel.com, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <54DF0C1B-8F45-4191-A5DF-16C2CB1F78A6@iscas.ac.cn>
References: <20260626132252.38377-1-vulab@iscas.ac.cn>
To: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID: qwCowADXfdYKm0BqqCuqAw--.7249S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4xZF4fur4DuFWfJF1kZrb_yoW8GrWkpw
 4rJa4jyryfA3W7tay7uF4FqFyfX3ZxGFWxuw1qkw4fuw15C3W8J3sY9Fy7WF1UArZ3Gr13
 AwnrtFyxt3WjyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUPEb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF
 64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcV
 CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280
 aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
 CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvj
 eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxw
 CY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
 JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1V
 AFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
 8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
 UjIFyTuYvjxU7miiUUUUU
X-Originating-IP: [117.182.74.7]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgMMA2pAhrYiNgAAsE
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



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 21:22=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> When heap_fence_create fails, the early error path calls kfree(active)
>  directly instead of __live_put(active), bypassing the kref_put path =
that
>  would call i915_active_fini for proper resource teardown. This skips
>  cleanup of the i915_active state while the initial kref from =
kref_init
>  remains unbalanced.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 5361db1a33c7 ("drm/i915: Track i915_active using debugobjects")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/gpu/drm/i915/selftests/i915_active.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/selftests/i915_active.c =
b/drivers/gpu/drm/i915/selftests/i915_active.c
> index 9fea2fabeac4..8ec7859da762 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_active.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_active.c
> @@ -91,7 +91,7 @@ __live_active_setup(struct drm_i915_private *i915)
>=20
> 	submit =3D heap_fence_create(GFP_KERNEL);
> 	if (!submit) {
> -		kfree(active);
> +		__live_put(active);
> 		return ERR_PTR(-ENOMEM);
> 	}
>=20
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang=

