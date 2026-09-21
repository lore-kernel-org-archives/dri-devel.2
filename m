Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F328C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 12:43:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61DC010E75E;
	Mon, 21 Sep 2026 12:43:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RjNhQMW0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IVxajd3/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC31710E151
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 12:43:32 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LAdmEd227824
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 12:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YTc4eaTqTCWWXmcCsM9hd8rF0EjF2lDAr6pE9wv6n6k=; b=RjNhQMW0qXvCl9e7
 TSqSjkDCMfDvn3tLw3Cir5ZYA42nfF6E17HauGaX61Fj0ylBQweO2l6cu7Ja1ckf
 bTkYPxta1GMCaU3pKkI2VxKH3oak+zv+0Td9/U1IMNUWo9PGFgsaXdK0JbDAjy8E
 9WUe4FSN44FrQeReNOrusu4zefIi2DGS7SlM93UNUJZ92ubgeva2ZyevUEOjxHgm
 1KotCQAkWGKs8y5QQHk3iqcJBOR/BwzySMjwYrff7wXQWAIWtINpjTKMkhDJSjpT
 vrUr230c/RwSaC9P6ePBdhDIZFQVeApKVBjMFEfHcYYTAeFF6AZOdcpBgQs4XRUb
 HmK6/g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu17grxd1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 12:43:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2db8c152622so27555375ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 05:43:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789994611; cv=none;
 d=google.com; s=arc-20260327;
 b=HUbzM7HNUNl2sTPon0etU7Grmi3NpgHhiYtnG9A4XAh7kouSiba9jEwBoMVLVcV67y
 m7E8efSA+DptuXjvWd66AdWLuxbmSZ10kiPGAMx1B9qG9KaRzot2cGfVofpOGv42C0rG
 kN5T+/nCwmI5uyjivpseRLgNfzVs2yVc7Q3Xs4ALhJQY4mGpgoK1uS2Txl7xHvmnzRhF
 OKTNg88Wet/bOYdYJz+HhVgRvUSFf78CJU8UwOny+cQ2vRPDLShXnZP61v/4ore/0foI
 lxXhw4UAiVzduTQmALmvtTT+rgcSp0ZxCe1snBdjPbIpn46lgtOSiLvv2KdK0Bj54nsQ
 gftA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YTc4eaTqTCWWXmcCsM9hd8rF0EjF2lDAr6pE9wv6n6k=;
 fh=2AqM8kfN7k33/iUwOuvFWoEEB7s00+aWNjO2QE2OQ7o=;
 b=cM80v7tAQLmakW2dOzY9HRxrs37ItgCY60utFRGml/v6QjExST0gMyJWFqeRhqB33P
 u4W9hrBaJd091Rc1h1BXcxk+jdJlYwFU6y5dDl3uy5jgGftUqaE4z7A2NQ0qzg3nEswX
 mNTFRYCW7Bh1/W/I2wgCW20sh10D5N8hJ26D301jNXRYwrUpGP+PI4iOxNFL22vj3s3T
 zTgD2D6KD8PDEnMfhkPTbL6W3uRvRMD5vQQrlTLEIJ+/AroJrkJL/7pAPdUo4Qlovlec
 dmRr4Upmcsxbn+yOZGYqpVfR/jzzi9ZV1QE2rAkIJb+s23I9iPTZTV+Eb/QPDAk3z/+L
 rMuQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789994611; x=1790599411;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YTc4eaTqTCWWXmcCsM9hd8rF0EjF2lDAr6pE9wv6n6k=;
 b=IVxajd3/30Qm6f7Xb6bQ93o0vEheA9jzY195SF414mlr7lGHrrP9XlsaHEJCj5TPh6
 Vorp+53HFW0d8E8GIUogsawIFwSPlIKVDcHNInrMJCytTlSMwlSctTZkp9JtuBvUpXj7
 BaED/qYxxo1cNp7tsOZ16YiipOVLfzyQCWJdl/nq7stesp+M7Sn6VCm8Bgt2VqqxczGD
 qakD9VVXfX5oDQ6/A8rFcIVdwUcHUxcC6ocq05iEpiP3Vxu0LNZ6Ien/uRxm543s0VV8
 hGfIZtyuT+1UrSj4A7Aah3Ev3TcJvMhynkZ68WPZBrXjrv/UV/XbZi8Gnpo7Skd1xV/h
 5J6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789994611; x=1790599411;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YTc4eaTqTCWWXmcCsM9hd8rF0EjF2lDAr6pE9wv6n6k=;
 b=wIPO1e/oABmdYtLwvqA54L4ZQlekzlGqxCCZTWyUw1u/x65IktEIYweHR0HqD+Zg00
 NEhCb3T8njgD3iZ1UkJ2ePavDrVXmRzpCUcppkrxj2SDOVaT2rMakvLKgFp5lOWhJXLr
 SgseZoaMYaSGgRtFfdNHk+7qA5parWsfmPRLgS3HsSlFyqtEMdTdQg0zbpkmW/qSHcV7
 DeHFc8qenWCuReoV65c+jVkcQINhsk9G5gexu5V0APhc2YiAVbJIu0ZeFEw+dT68xRGm
 kXu6fhhQvBozhh8Sk5ay27i4G/5OQzTkpmSqKh6T2P42XuNSVOK0IXLVK1qHPm9DFl1H
 xgUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByJh9d/pWWkVrZSma+EzAIPHmnbxiKk1FwGcslanM0PIbI6fzGZ3QWAy/1XVYbVDpRLqCPecjj0/bk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mWsqbCsK0xv98cAkHRBinNEbGmtADAMMTesntmgL2UITyTAKvI
 mkKJlFVbdMhKPh/m3XMJkC3P7Sp9zhjvihaMHLDLYaM5WjQnBN/kT50bGLIFjgElfeGk+I+c7zs
 o11HBFh2Da5nU1YYtsbLlJys36hhiFtLtobs8pqJaT/WDicZQ+scruBs3kO/3BlkDAhGP8glWBP
 aSCyGdVOtCQsbOyEXa+z0lBsfLO/OWDiWPZZUIN78lIhFP8A==
X-Gm-Gg: AYBFou1DN1nXItbdtnBEssOsDUnxyR+gPeqiuzkzKbKGnUAnbbjlAgOZRK5joxtDasJ
 lFNRq6x4wqy00dlZGwC7y1ogU4LqNb/GOPVNGFUP8zXOWOl8O6jPYZ6012xVZm2UQqtd+1p9omB
 w+QfO3q9Joa/WpcmlY7zOEDkujndIqfAVCi1z99DTLneunYDM5EESjt/UOPw==
X-Received: by 2002:a17:903:2349:b0:2dd:c100:424e with SMTP id
 d9443c01a7336-2ddc10044e2mr89288795ad.50.1789994611237; 
 Mon, 21 Sep 2026 05:43:31 -0700 (PDT)
X-Received: by 2002:a17:903:2349:b0:2dd:c100:424e with SMTP id
 d9443c01a7336-2ddc10044e2mr89288245ad.50.1789994610661; Mon, 21 Sep 2026
 05:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260915104328.45901-1-gahing@gahingwoo.com>
 <20260915104328.45901-11-gahing@gahingwoo.com>
In-Reply-To: <20260915104328.45901-11-gahing@gahingwoo.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 14:43:19 +0200
X-Gm-Features: AcwNN1XRM4Zpoe9SV6Ox1cb4qr0Qhj7z7Tg6kKrM_v7MoPDIacNjWOamn5qOldA
Message-ID: <CAPx+jO_MFkUrzRDnuoqn_yKntRc_NqPs=0nda6wC_xgb+Fy7bw@mail.gmail.com>
Subject: Re: [PATCH v13 10/14] pmdomain: rockchip: cycle optional power-domain
 resets on power-on
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, ulfh@kernel.org,
 p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com,
 royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: YaJzL7yMHn4QqvCR3culG8VfQQMH_4n2
X-Authority-Analysis: v=2.4 cv=IewSymqa c=1 sm=1 tr=0 ts=6ab12674 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=9GNsruGHAAAA:8 a=EUspDBNiAAAA:8
 a=xnVI1lRHtBAIIYlgu6QA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=gf-oSkQAjqHFJRp-GQfY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE4MiBTYWx0ZWRfXy3daOWNZdAJM
 HNvFN+iFWg5u7+hRGRsg0Jp/3MzNdtEHVwPWKLMEJB8KWYcZtmQXkwOFw+U2GCqf2lyRWHAVm1Y
 GL3rwWveCr6Tk5UFgGGvXdK51Rqiqn/XRgWKAkTMyJNdDFH+/hvFo0PUd3uNRGWhs2QEnEQ5ViE
 LCZB5haXWn5vM7gYJZg98CzCykNEeA78s7exMlV0Jj/CJ8zCD3cJvpnEuH9Jg80RtX+XLv5+yJ4
 KOvXPQtHE0mHrrJDt0lsBUYPzV7HYyOPA1euSE/Rkow+6GdA/A+XwTuU/IQ6kXUcdSql0aFyCQu
 tRvMjk+l/5fXAqJ4jAiC8NcZirezF99k1EGIqBMqCdPaIkq36BbJUEgTZUWpYTcZ2IVNBZOb6i0
 cTF4AJ42BzcZimw/l1hemYiO6WKUnMmrojcl9W88oULpd7NAXoYa/40mRxhhXkaSRWNG4H9hcsA
 q1pd/Ei0Y6AoVJQw1ig==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE4MiBTYWx0ZWRfX+FKEhWLSGC7u
 /OCl7X0D9/W0lVGOX327m+3t2uDI4UrRPgNChxainBYU48YjYKOWsIUwDGzCYci8e9KHPUA1l0f
 3QEHinJFOoJ4gFJsbsPQfTJmLJP+2JI=
X-Proofpoint-ORIG-GUID: YaJzL7yMHn4QqvCR3culG8VfQQMH_4n2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210182
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

On Tue, Sep 15, 2026 at 12:45=E2=80=AFPM Jiaxing Hu <gahing@gahingwoo.com> =
wrote:
>
> Some Rockchip domains come out of power-on with their bus interface in an
> undefined state. On the RK3576 NPU this shows up as a hang on the first
> register access after the domain is switched on, and pulsing the domain's
> resets at this point clears it.
>
> Take the domain node's resets if it has any, and pulse them between
> releasing idle and restoring QoS. The resets are optional, so domains tha=
t
> do not list any are unaffected.

Please drop the below from the commit message, the above is clear
enough I think!

>
> The cycle goes before the settle delay 9/14 adds, not after it. A domain
> that asks for both is asking to settle before the QoS registers answer, a=
nd
> a reset deasserted after the delay would leave nothing between the deasse=
rt
> and rockchip_pmu_restore_qos(). On RK3576 PD_NPU0 and PD_NPU1 ask for bot=
h,
> and the reset they cycle is SRST_A_RKNN0/1_BIU, the bus interface those Q=
oS
> writes go through.
>
> It only runs when the domain actually changes state: rockchip_pd_power()
> returns early when the hardware already reads the state being asked for. =
A
> bootloader that leaves the NPU powered would therefore skip both this and
> the delay, which is why 9/14 gives RK3576_PD_NPU need_regulator and force=
s
> the domain off at probe.
>
> No in-tree DTS puts resets in a power-domain node today, so every other
> Rockchip SoC takes the optional get's NULL and is unchanged.
>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

Kind regards
Uffe

> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 27 ++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index 39988efd8..6cc8d6efd 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -19,6 +19,7 @@
>  #include <linux/of_clk.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/reset.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/mfd/syscon.h>
> @@ -103,6 +104,7 @@ struct rockchip_pm_domain {
>         struct clk_bulk_data *clks;
>         struct device_node *node;
>         struct regulator *supply;
> +       struct reset_control *resets;
>  };
>
>  struct rockchip_pmu {
> @@ -688,6 +690,21 @@ static int rockchip_pd_power(struct rockchip_pm_doma=
in *pd, bool power_on)
>                 if (ret < 0)
>                         goto out;
>
> +               /*
> +                * Optional: some domains need their resets cycled once p=
ower
> +                * is on. This goes BEFORE the settle delay, not after: a
> +                * domain that asks for both is asking to settle before t=
he
> +                * QoS registers answer, and a reset deasserted after the
> +                * delay would leave nothing between it and the QoS write=
s.
> +                * On RK3576 the reset being cycled is the NPU core's bus
> +                * interface, which is what those writes go through.
> +                */
> +               if (pd->resets) {
> +                       reset_control_assert(pd->resets);
> +                       usleep_range(10, 20);
> +                       reset_control_deassert(pd->resets);
> +               }
> +
>                 /* Some domains need to settle before the QoS registers a=
nswer. */
>                 if (pd->info->delay_us)
>                         udelay(pd->info->delay_us);
> @@ -861,6 +878,14 @@ static int rockchip_pm_add_one_domain(struct rockchi=
p_pmu *pmu,
>         if (error)
>                 goto err_put_clocks;
>
> +       pd->resets =3D of_reset_control_array_get_optional_exclusive(node=
);
> +       if (IS_ERR(pd->resets)) {
> +               error =3D dev_err_probe(pmu->dev, PTR_ERR(pd->resets),
> +                                     "%pOFn: failed to get resets\n", no=
de);
> +               pd->resets =3D NULL;
> +               goto err_unprepare_clocks;
> +       }
> +
>         pd->num_qos =3D of_count_phandle_with_args(node, "pm_qos",
>                                                  NULL);
>
> @@ -931,6 +956,7 @@ static int rockchip_pm_add_one_domain(struct rockchip=
_pmu *pmu,
>         clk_bulk_unprepare(pd->num_clks, pd->clks);
>  err_put_clocks:
>         clk_bulk_put(pd->num_clks, pd->clks);
> +       reset_control_put(pd->resets);
>         return error;
>  }
>
> @@ -949,6 +975,7 @@ static void rockchip_pm_remove_one_domain(struct rock=
chip_pm_domain *pd)
>
>         clk_bulk_unprepare(pd->num_clks, pd->clks);
>         clk_bulk_put(pd->num_clks, pd->clks);
> +       reset_control_put(pd->resets);
>
>         /* protect the zeroing of pm->num_clks */
>         mutex_lock(&pd->pmu->mutex);
> --
> 2.43.0
>
