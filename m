Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48A0C43327
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 03:53:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF66810E557;
	Sun, 28 Jun 2026 03:53:12 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9812910E557
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 03:53:10 +0000 (UTC)
Received: from smtpclient.apple (unknown [117.182.74.7])
 by APP-01 (Coremail) with SMTP id qwCowAA33NRbmkBqExKqAw--.34181S6;
 Sun, 28 Jun 2026 11:53:08 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: accel/qaic: qaic_attach_slice_bo_ioctl: success path
 missing   drm_gem_object_put
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626114359.32938-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 11:52:58 +0800
Cc: carl.vanderlip@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3CC7319B-899B-42C4-AA98-729288B9E95D@iscas.ac.cn>
References: <20260626114359.32938-1-vulab@iscas.ac.cn>
To: jeff.hugo@oss.qualcomm.com,
 ogabbay@kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID: qwCowAA33NRbmkBqExKqAw--.34181S6
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4xKF4xGF18JFW3Xw4UCFg_yoW8GF45pr
 WagFW7trZ8XrWUKrW2vr1DWFyjkw1Y93yUKayrA34S9rnYgFyUZa45WFZ8XFn3try7CFZ0
 qr1jv3ZYg3W2ya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBlb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
 jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI
 8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E
 87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
 AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
 Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMx
 AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
 Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwI
 xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
 JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
 C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8geOJUUUUU==
X-Originating-IP: [117.182.74.7]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwAMA2pAixEZagAAsL
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



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 19:43=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> drm_gem_object_lookup() acquires a GEM object reference on success. =
All
>  error paths correctly release it via put_bo, but the success path =
returns
>  without calling drm_gem_object_put(obj). Since list_add_tail does not
>  transfer ownership, the GEM object reference is permanently leaked on
>  each successful call.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 75af0a585af9 ("accel/qaic: Grab ch_lock during =
QAIC_ATTACH_SLICE_BO")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/accel/qaic/qaic_data.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/accel/qaic/qaic_data.c =
b/drivers/accel/qaic/qaic_data.c
> index 1e4c579d2725..b17df7bf565d 100644
> --- a/drivers/accel/qaic/qaic_data.c
> +++ b/drivers/accel/qaic/qaic_data.c
> @@ -1084,6 +1084,7 @@ int qaic_attach_slice_bo_ioctl(struct drm_device =
*dev, void *data, struct drm_fi
>=20
> 	bo->sliced =3D true;
> 	list_add_tail(&bo->bo_list, &bo->dbc->bo_lists);
> +	drm_gem_object_put(obj);
> 	srcu_read_unlock(&dbc->ch_lock, rcu_id);
> 	mutex_unlock(&bo->lock);
> 	kfree(slice_ent);
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang=

