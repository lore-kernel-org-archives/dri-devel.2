Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E32C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 03:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29D7D10E55A;
	Sun, 28 Jun 2026 03:55:00 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D06F210E55A
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 03:54:58 +0000 (UTC)
Received: from smtpclient.apple (unknown [117.182.74.7])
 by APP-01 (Coremail) with SMTP id qwCowADXfdYKm0BqqCuqAw--.7249S2;
 Sun, 28 Jun 2026 11:54:51 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: drm/display: drm_dp_mst_topology_mgr_set_mst: error
 path after DPCD   write failure leaks MST branch device reference
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626125117.37153-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 11:54:40 +0800
Cc: dmitry.baryshkov@oss.qualcomm.com, kees@kernel.org, liviu.dudau@arm.com,
 suraj.kandpal@intel.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <74B9C429-5BBD-492D-B4D1-ABE168D68D14@iscas.ac.cn>
References: <20260626125117.37153-1-vulab@iscas.ac.cn>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID: qwCowADXfdYKm0BqqCuqAw--.7249S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4DKw17WFWkKF4ftF4fXwb_yoW8Xw47pr
 W2kry2yr93JanFyr4UZF18WFWUKa9xAryrGF4UWw4fWw1UAr18Wa48tF1aqF17ArW2kr1f
 twsrCF18GF1qkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9jb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4
 vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
 Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJV
 W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka
 0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
 v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
 1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIx
 AIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
 IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
 C2KfnxnUUI43ZEXa7IU8Y2NJUUUUU==
X-Originating-IP: [117.182.74.7]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwUMA2pAixEZuAACse
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



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 20:51=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> drm_dp_add_mst_branch_device initializes mstb with refcount 1, and
>  drm_dp_mst_topology_get_mstb increments it to 2. When
>  drm_dp_dpcd_write_byte fails, out_unlock performs only one
>  drm_dp_mst_topology_put_mstb, leaving the other reference stored in
>  mgr->mst_primary. Since MST was not successfully enabled, no disable =
path
>  will clean it up.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 7a3cbf590e63 ("drm/mst: Some style improvements in =
drm_dp_mst_topology_mgr_set_mst()")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/gpu/drm/display/drm_dp_mst_topology.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c =
b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index 8757972e8e24..db9441c80cd5 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -3679,8 +3679,10 @@ int drm_dp_mst_topology_mgr_set_mst(struct =
drm_dp_mst_topology_mgr *mgr, bool ms
> 					     DP_MST_EN |
> 					     DP_UP_REQ_EN |
> 					     DP_UPSTREAM_IS_SRC);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			mgr->mst_primary =3D NULL;
> 			goto out_unlock;
> +		}
>=20
> 		/* Write reset payload */
> 		drm_dp_dpcd_clear_payload(mgr->aux);
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang=

