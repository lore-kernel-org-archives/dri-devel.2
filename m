Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DDBC43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 03:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3146C10E559;
	Sun, 28 Jun 2026 03:53:52 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 343DB10E559
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 03:53:49 +0000 (UTC)
Received: from smtpclient.apple (unknown [117.182.74.7])
 by APP-01 (Coremail) with SMTP id qwCowAA33NRbmkBqExKqAw--.34181S8;
 Sun, 28 Jun 2026 11:53:45 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: dma-buf: fence_chains_init: error unwind path leaks 
 enable_sw_signaling reference
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626121825.35310-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 11:53:35 +0800
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CE05A9E5-BE2C-4180-B14E-74794C1286DF@iscas.ac.cn>
References: <20260626121825.35310-1-vulab@iscas.ac.cn>
To: sumit.semwal@linaro.org,
 christian.koenig@amd.com
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID: qwCowAA33NRbmkBqExKqAw--.34181S8
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1kJw1DuF1kJFyDCF13CFg_yoW8XF4Upa
 95Kr4UKr98KFyxZw47AF4DtFyFkws5Jry8WF4jka4fZ3s8Za4UJw4vy3y2qFZ8Gr97GF43
 Jw15Cry5GF15AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBCb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
 jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI
 8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
 z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
 IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4U
 McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtw
 CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
 6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64
 vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_
 Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42
 IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUgT7NUUUUU
X-Originating-IP: [117.182.74.7]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwgMA2pAixEZfgABsW
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



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 20:18=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> dma_fence_enable_sw_signaling acquires an extra reference on each =
chain
>  fence. The error unwind loop calls dma_fence_put only once per
>  chain/fence without first signaling the fence to trigger the callback
>  that releases the signaling reference. This prevents the chain fence =
kref
>  from reaching 0, permanently leaking the chain and its contained =
fence.
>=20
> Cc: stable@vger.kernel.org
> Fixes: dc2f7e67a28a ("dma-buf: Exercise dma-fence-chain under =
selftests")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/dma-buf/st-dma-fence-chain.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/dma-buf/st-dma-fence-chain.c =
b/drivers/dma-buf/st-dma-fence-chain.c
> index 821023dd34df..7dc18e294387 100644
> --- a/drivers/dma-buf/st-dma-fence-chain.c
> +++ b/drivers/dma-buf/st-dma-fence-chain.c
> @@ -152,7 +152,10 @@ static int fence_chains_init(struct fence_chains =
*fc, unsigned int count,
>=20
> unwind:
> 	for (i =3D 0; i < count; i++) {
> -		dma_fence_put(fc->fences[i]);
> +		if (fc->fences[i]) {
> +			dma_fence_signal(fc->fences[i]);
> +			dma_fence_put(fc->fences[i]);
> +		}
> 		dma_fence_put(fc->chains[i]);
> 	}
> 	kvfree(fc->fences);
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang=

