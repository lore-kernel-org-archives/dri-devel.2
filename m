Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E004C982EE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 12:41:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC46510E5BF;
	Mon, 21 Sep 2026 12:41:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ElvYsXrW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bTrMhUbM";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31A2D10E5BF
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 12:41:24 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LB4low1129676
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 12:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MCkUtZMQ71ULc4B874+EyT+6Pil1L5OznKSmBdpWeOQ=; b=ElvYsXrWBfG26UY6
 V2FjiXMbFsn2iyvAOqIpcKtWlHbfEpYrsN6TuG8RGba9ur7ykT+VMqKDB6YY5Rdu
 1RgTFl1vWgXfnbVkwWcxf8tyuw1JV8PUXYsoMkDE/AyYgLpnPTelKF9tb1jP4BXd
 mL0V9Es9ZkHSHoco2uWla/d3HWZV2M56jQLiizIyJhzsYWg772rzH4yYChe/lw0k
 iCNPyj3ISyHBL5ZKAB1+VNxtGfqh3bZeevfKNbdl9eYwXswY08YbDJK4NQlUzx7e
 JRgjm81AofSvqE3tFcngODmLTOTYmlzusB8VknB9JCHVqBUGByOZc18OzTDYHpF8
 08b3gQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu3csgb9a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 12:41:23 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cbedbd182f5so2545433a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 05:41:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789994483; cv=none;
 d=google.com; s=arc-20260327;
 b=nZXNrREMdvzXEM29vkhQ939keuQQ3kLOUMYvIHNQcE2/1BYtcoLys5cfC+jCTyVp+m
 GDjDhFHzijZMxw1shHyMaI8jXDu/Ov8CJxCUQvP3hI3XiF+JV/BTvzZUHj2RDA63P7Lz
 q2nkUKGiOnJJ3MFO5lC8u70lIpADVZ22Kv0vMMpuiMRDSNrefJbuxIQsgqyiwt/Rt6f9
 qmMlQzpb/2DfrRDLbQImVLt89uynk27bxK68zycG+MLkqDsNeDjqPO1T5aCpTlX7HJ0g
 4y1dxVae+KewEKB7PC30BPhVlG/mp8cv1aSeZFjq546yGXABc4ypek51ARqHypW5uhbk
 mkLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MCkUtZMQ71ULc4B874+EyT+6Pil1L5OznKSmBdpWeOQ=;
 fh=fC/bbQAHin71hHhPGgdK2zJwoYhO/oQpUvEe6XPqJns=;
 b=STwW4oQJJJ5AQRVl4QvIrCE4Y3M7kuJ4d///IV3zrYgExtoB+k0DNS2lha7goRJPNo
 pYSZ5EdhXxZmmIGFuPTXq0lJ2B4yefJp8UI4ftk41xEkqo7wcPr4Q+Z7A2Ua28+20Hia
 SNBfqMmdDFwzMaDqu7llKYiOoZUEzia5yKNdmm7V6Hjaj03cKWlJNQ6C6x9vLIvPQ63z
 AHCdGEWiTkVkCeDt4ClB3//cxu+cRX9fKSaJu5lNLQkaR5hXIBiU9qH1+cdO1IEvIZsL
 aYtooYEKgQFNo54tcbjUEwm4PF5BtltNuHzM8cHzRCVVQEsJaFnHBRh2wLxrFMVn9rKp
 4CDw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789994483; x=1790599283;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MCkUtZMQ71ULc4B874+EyT+6Pil1L5OznKSmBdpWeOQ=;
 b=bTrMhUbMbo/reQ01L7pQcW/HP42gaju5AcsHpGO8htUrISpqStQ7Vm8nIySnyLtpCZ
 DeWxZOqVoOs3nUQ3pQid9SDdX8Eem4Qy+0ah2J0VIqoeruv8avgaL+ljy45HIig0NK8u
 TYL+s4QMDgUj6QOrpPD/bm5Y2+uOpUIUcixCbbmx9u7EJO2F8yEH6z96vLsKssf6fp24
 b3gvdAAbX7t3YsdgDp15PWrxrcgk2fYBNhDNZx7Qcx+Aa9tssAyQELUmoEVOk6JcULHp
 mp4WKwWEIWMOANUXe28IdrlSfizQJiINCfXYaa+2nkvRTLOo+Lj5y49tl10edH7O8fnz
 e7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789994483; x=1790599283;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MCkUtZMQ71ULc4B874+EyT+6Pil1L5OznKSmBdpWeOQ=;
 b=NSV61n7/Edk9p+eKH8O4aR+KN+lCL5jiDsxXPY3g2tZxL0WyxXC3il9gcb68HeBA1H
 Gc5J0jy8QLI0Jgbo6mtGexkBXYl5VmB8xYlfWwMqBTXlhUXDUAovSo9AuH8DFoeyp44C
 498X+wKKc16gIydrLDLv1iU+gKabqt9scg9LrefwTq8Q04oB0Srem3lrXGJSSsw5BBVh
 QRq8Er5czYshG+pnIO63PNzDDbm/KxsY2/YFZKCGBqMJdZrount1erDX+2daLep14GsA
 kh6ZQ9de/HFC9H4ecYrzvO0BMY0deRSERpGr1y6mfxXJoJ3k/nzgsQ5Z0vtzoHPR/Jdp
 c4Sw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0j0qQcTGSK3h9p4gF/+YARQES+zZnm4RktAN6eJsGhW1UQ0CI4K1mrX0aOgIDPNLxQAbb+rInm1E=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nZdr2qcbgA1KTGek0gGrglJCDQLElpiXS9psAC/PwAIKICBZn1
 8lsKHmQ9eJ+ilZUI77YgOpZJ/xHOkT6rXDk0Ybe8vhBbHQnIdutl+35gE8LYWMj8BEAT4Zrc7i8
 6sTA2MqGkldZgQsgVD86qiRVokU0VK9YK+dE6go9hBr2p0KQs+VAuGZwXxxEcWsH0BtgqUW7nlP
 LnYQWfD4HQUkXIe7DP/CqslVEDrZWlPBWWemC4o0ZXV/RjAQ==
X-Gm-Gg: AYBFou3iJ/wZFNPEbtqAPYOzDnTw+M86ZxuyZSnkuqmSF9ci7ojRwCAOaVnhvnCY0/G
 mozADkytmn04ubk4wQUmtKlkxfk8b7bEEdAqVFKDmIL3vG0noCqUOyNDjgyLGAdCSM3k4Q2IFMS
 E6nkRTDZUyHmyevUvb6RRs99OgEpqOPdYegIklKpMD1yernEY24sLebz56Kw==
X-Received: by 2002:a05:6a20:728e:b0:3db:b3b:5343 with SMTP id
 adf61e73a8af0-3dd72553e40mr19632629637.12.1789994482618; 
 Mon, 21 Sep 2026 05:41:22 -0700 (PDT)
X-Received: by 2002:a05:6a20:728e:b0:3db:b3b:5343 with SMTP id
 adf61e73a8af0-3dd72553e40mr19632577637.12.1789994482080; Mon, 21 Sep 2026
 05:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260915104328.45901-1-gahing@gahingwoo.com>
 <20260915104328.45901-10-gahing@gahingwoo.com>
In-Reply-To: <20260915104328.45901-10-gahing@gahingwoo.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 14:41:09 +0200
X-Gm-Features: AcwNN1U_m4mjOUzjWYeAqWZntQVfxzbTcYRMim6iZjC6YeWC6g3-sc-ZIdGx-1E
Message-ID: <CAPx+jO--v8dHGCTMQrooxm7dLPDYbUHt4euWTud-GKK7efOuZA@mail.gmail.com>
Subject: Re: [PATCH v13 09/14] pmdomain: rockchip: add optional per-domain
 power-on settle delay
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE4MiBTYWx0ZWRfXy3yWTjMhpiNo
 rHsHIMMyHuV9tLiR9xAVetfWVwcWpB9AHFrMi7TqZZzm4F2iu1NpPVGfAt/FW4Z8ax4T65d1qGg
 8JuvBedIgPWXFukl8PQrTSLoTs1nRMI=
X-Proofpoint-GUID: QnVIUkzrVlI4HwG800HG6LzojkQNkwDF
X-Authority-Analysis: v=2.4 cv=QovLTlyd c=1 sm=1 tr=0 ts=6ab125f3 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=9GNsruGHAAAA:8 a=EUspDBNiAAAA:8
 a=TQVB6zonJKZT9JHDKKgA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=gf-oSkQAjqHFJRp-GQfY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE4MiBTYWx0ZWRfX/wgr3MKNpE0Y
 RKKNS+8PKQz7JyzHO3wFTQipBVx08CeL6/EXV4413txs07tx2cKcLz4t47/fnOepn2N4A6rQ22J
 W5W0Scj+8UjkgFPdySOKn16IZMthRDxiV7M8a6ifARTaKfQ1Cm9wVdeWK0a5HI9c8qkLlC7b2PP
 cKtVMra4h7urrRX4sEtgzUc3xZaKmr8wneZ0XxQeLjyMdVaR6Xf3OyyMXUCl993dXR1mTAQjEgP
 jGKAdF8yOcRP3C+9XJ3o5972Y/muuqdFaC0KssITMgbrNmP2SQ3cmK5m0GjPOoVE9harDH5EvIY
 t8N05w2g74pnuVKcP6CbFk5jspDewSG/DH2L697Yx+nmIq4encazS4W0bH4NLC6kLr/zY8bFUhc
 DOY1goNa7SaaGyuwhWrp8XKwYxHp3qNhZQnv9ttZtP9Pq5Z45gh4HI7gpG8WsJaFcy6IVqseMVs
 51bDGflXctwU1bJmLew==
X-Proofpoint-ORIG-GUID: QnVIUkzrVlI4HwG800HG6LzojkQNkwDF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210182
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
> The RK3576 NPU domains need a short settle time after the idle request is
> released before the registers behind the domain answer. Without it the Qo=
S
> writes that rockchip_pmu_restore_qos() issues land while the domain is
> still coming up, and the NPU throws an async SError on the first cold
> power-on.
>
> Give rockchip_domain_info an optional delay_us and wait for it between
> releasing idle and restoring QoS. Rename DOMAIN_M_O_R_G to
> DOMAIN_M_O_R_G_W for the settle delay it now carries; RK3576 is its only
> user, so the old spelling is not kept around.

To me, everything below in the commit message can just be dropped. The
above is clear enough.

>
> The suffix scheme does not survive this cleanly and it is worth saying so
> rather than leaving it for review. The letters name fields, but R already
> means two things in this family: DOMAIN_M_O_R takes r_status and r_offset
> AND a regulator under one R, while DOMAIN_M_R has no repair fields and it=
s
> R is the regulator. DOMAIN_M_O_R_G's R was the repair pair -- it did not
> set need_regulator at all -- so the paragraph below, which gives it one,
> adds a field the name does not mention. Naming it _W_R or _RG would be
> inventing a convention rather than following one. Say which you would
> rather have.
>
> While the macro is being rewritten, give it the regulator argument that
> DOMAIN_M_O_R and DOMAIN_M_R already take. Without .need_regulator set,
> rockchip_pd_regulator_enable() returns early for every RK3576 domain, so =
a
> domain-supply in the device tree is never looked up and never enabled. Ad=
d
> a DOMAIN_RK3576_R spelling that passes true and use it for RK3576_PD_NPU,
> which is the one RK3576 domain with a rail of its own; every other domain
> passes false and is unchanged.
>
> Two things beyond the delay, both worth saying out loud because neither i=
s
> what the subject describes.
>
> RK3576_PD_NPU also gets need_regulator here, which makes
> rockchip_pm_add_one_domain() call rockchip_pd_power(pd, false) at probe o=
n
> all thirteen in-tree rk3576 boards. Only rock-4d enables an NPU core, and
> it is the one that declares the supply, so on the other twelve ->power_on
> never runs and the regulator is never looked up at all. It is deliberate,
> and it is what the delay is for:
> without the domain being forced off at probe, a bootloader that leaves th=
e
> NPU powered means ->power_on is never called and neither the delay nor
> 10/14's reset pulse ever runs.
>
> This is not new behaviour in this driver. RK3588_PD_NPU has carried
> need_regulator since it was added and its req_mask is 0 exactly as this
> one's is, so rockchip_pd_power(pd, false) has been running at probe on ev=
ery
> rk3588 board, with rockchip_pmu_set_idle_request() returning immediately
> because there is no request to make. Of the forty-nine in-tree rk3588 boa=
rd
> files, twenty-one enable an NPU core and declare the supply, twenty-six d=
o
> not enable one at all so ->power_on never runs for them, and two enable i=
t
> with no supply: quartzpro64 and youyeetoo-yy3588 take the dummy regulator
> and the one line dev_warn from the regulator core today. The idle
> handshake lives in the child domains and on both SoCs they keep it:
> NPUTOP, NPU0 and NPU1 carry req and idle masks of their own.
>
> If that is too much for one patch, say so and it splits.
>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

Other than the nitpick above, this looks good to me!

Kind regards
Uffe

> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 56 ++++++++++++++++----------
>  1 file changed, 34 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index ba66ae719..39988efd8 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -18,6 +18,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_clk.h>
>  #include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/mfd/syscon.h>
> @@ -59,6 +60,7 @@ struct rockchip_domain_info {
>         u32 pwr_offset;
>         u32 mem_offset;
>         u32 req_offset;
> +       u32 delay_us;
>  };
>
>  struct rockchip_pmu_info {
> @@ -185,7 +187,7 @@ struct rockchip_pmu {
>         .need_regulator =3D regulator,                    \
>  }
>
> -#define DOMAIN_M_O_R_G(_name, p_offset, pwr, status, m_offset, m_status,=
 r_status, r_offset, req, idle, ack, g_mask, wakeup)   \
> +#define DOMAIN_M_O_R_G_W(_name, p_offset, pwr, status, m_offset, m_statu=
s, r_status, r_offset, req, idle, ack, g_mask, delay, wakeup, regulator)   =
    \
>  {                                                      \
>         .name =3D _name,                                  \
>         .pwr_offset =3D p_offset,                         \
> @@ -200,8 +202,10 @@ struct rockchip_pmu {
>         .req_mask =3D (req),                              \
>         .idle_mask =3D (idle),                            \
>         .clk_ungate_mask =3D (g_mask),                    \
> +       .delay_us =3D (delay),                            \
>         .ack_mask =3D (ack),                              \
>         .active_wakeup =3D wakeup,                        \
> +       .need_regulator =3D regulator,                    \
>  }
>
>  #define DOMAIN_M_R(_name, pwr, status, req, idle, ack, wakeup, regulator=
)      \
> @@ -258,8 +262,11 @@ struct rockchip_pmu {
>  #define DOMAIN_RK3568(name, pwr, req, wakeup, regulator)               \
>         DOMAIN_M_R(name, pwr, pwr, req, req, req, wakeup, regulator)
>
> -#define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, r=
eq, idle, g_mask, wakeup)      \
> -       DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status=
, r_offset, req, idle, idle, g_mask, wakeup)
> +#define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, r=
eq, idle, g_mask, delay, wakeup)       \
> +       DOMAIN_M_O_R_G_W(name, p_offset, pwr, status, 0, r_status, r_stat=
us, r_offset, req, idle, idle, g_mask, delay, wakeup, false)
> +
> +#define DOMAIN_RK3576_R(name, p_offset, pwr, status, r_status, r_offset,=
 req, idle, g_mask, delay, wakeup)     \
> +       DOMAIN_M_O_R_G_W(name, p_offset, pwr, status, 0, r_status, r_stat=
us, r_offset, req, idle, idle, g_mask, delay, wakeup, true)
>
>  /*
>   * Dynamic Memory Controller may need to coordinate with us -- see
> @@ -681,6 +688,10 @@ static int rockchip_pd_power(struct rockchip_pm_doma=
in *pd, bool power_on)
>                 if (ret < 0)
>                         goto out;
>
> +               /* Some domains need to settle before the QoS registers a=
nswer. */
> +               if (pd->info->delay_us)
> +                       udelay(pd->info->delay_us);
> +
>                 rockchip_pmu_restore_qos(pd);
>         }
>
> @@ -1300,25 +1311,26 @@ static const struct rockchip_domain_info rk3568_p=
m_domains[] =3D {
>  };
>
>  static const struct rockchip_domain_info rk3576_pm_domains[] =3D {
> -       [RK3576_PD_NPU]         =3D DOMAIN_RK3576("npu",    0x0, BIT(0), =
 BIT(0), 0,       0x0, 0,       0,       0,       false),
> -       [RK3576_PD_NVM]         =3D DOMAIN_RK3576("nvm",    0x0, BIT(6), =
 0,      BIT(6),  0x4, BIT(2),  BIT(18), BIT(2),  false),
> -       [RK3576_PD_SDGMAC]      =3D DOMAIN_RK3576("sdgmac", 0x0, BIT(7), =
 0,      BIT(7),  0x4, BIT(1),  BIT(17), 0x6,     false),
> -       [RK3576_PD_AUDIO]       =3D DOMAIN_RK3576("audio",  0x0, BIT(8), =
 0,      BIT(8),  0x4, BIT(0),  BIT(16), BIT(0),  false),
> -       [RK3576_PD_PHP]         =3D DOMAIN_RK3576("php",    0x0, BIT(9), =
 0,      BIT(9),  0x0, BIT(15), BIT(15), BIT(15), false),
> -       [RK3576_PD_SUBPHP]      =3D DOMAIN_RK3576("subphp", 0x0, BIT(10),=
 0,      BIT(10), 0x0, 0,       0,       0,       false),
> -       [RK3576_PD_VOP]         =3D DOMAIN_RK3576("vop",    0x0, BIT(11),=
 0,      BIT(11), 0x0, 0x6000,  0x6000,  0x6000,  false),
> -       [RK3576_PD_VO1]         =3D DOMAIN_RK3576("vo1",    0x0, BIT(14),=
 0,      BIT(14), 0x0, BIT(12), BIT(12), 0x7000,  false),
> -       [RK3576_PD_VO0]         =3D DOMAIN_RK3576("vo0",    0x0, BIT(15),=
 0,      BIT(15), 0x0, BIT(11), BIT(11), 0x6800,  false),
> -       [RK3576_PD_USB]         =3D DOMAIN_RK3576("usb",    0x4, BIT(0), =
 0,      BIT(16), 0x0, BIT(10), BIT(10), 0x6400,  true),
> -       [RK3576_PD_VI]          =3D DOMAIN_RK3576("vi",     0x4, BIT(1), =
 0,      BIT(17), 0x0, BIT(9),  BIT(9),  BIT(9),  false),
> -       [RK3576_PD_VEPU0]       =3D DOMAIN_RK3576("vepu0",  0x4, BIT(2), =
 0,      BIT(18), 0x0, BIT(7),  BIT(7),  0x280,   false),
> -       [RK3576_PD_VEPU1]       =3D DOMAIN_RK3576("vepu1",  0x4, BIT(3), =
 0,      BIT(19), 0x0, BIT(8),  BIT(8),  BIT(8),  false),
> -       [RK3576_PD_VDEC]        =3D DOMAIN_RK3576("vdec",   0x4, BIT(4), =
 0,      BIT(20), 0x0, BIT(6),  BIT(6),  BIT(6),  false),
> -       [RK3576_PD_VPU]         =3D DOMAIN_RK3576("vpu",    0x4, BIT(5), =
 0,      BIT(21), 0x0, BIT(5),  BIT(5),  BIT(5),  false),
> -       [RK3576_PD_NPUTOP]      =3D DOMAIN_RK3576("nputop", 0x4, BIT(6), =
 0,      BIT(22), 0x0, 0x18,    0x18,    0x18,    false),
> -       [RK3576_PD_NPU0]        =3D DOMAIN_RK3576("npu0",   0x4, BIT(7), =
 0,      BIT(23), 0x0, BIT(1),  BIT(1),  0x1a,    false),
> -       [RK3576_PD_NPU1]        =3D DOMAIN_RK3576("npu1",   0x4, BIT(8), =
 0,      BIT(24), 0x0, BIT(2),  BIT(2),  0x1c,    false),
> -       [RK3576_PD_GPU]         =3D DOMAIN_RK3576("gpu",    0x4, BIT(9), =
 0,      BIT(25), 0x0, BIT(0),  BIT(0),  BIT(0),  false),
> +       /*                                            name    p_offset pw=
r      status  r_status r_offset req      idle     g_mask   delay wakeup */
> +       [RK3576_PD_NPU]         =3D DOMAIN_RK3576_R("npu",  0x0, BIT(0), =
 BIT(0), 0,       0x0, 0,       0,       0,       0,    false),
> +       [RK3576_PD_NVM]         =3D DOMAIN_RK3576("nvm",    0x0, BIT(6), =
 0,      BIT(6),  0x4, BIT(2),  BIT(18), BIT(2),  0,    false),
> +       [RK3576_PD_SDGMAC]      =3D DOMAIN_RK3576("sdgmac", 0x0, BIT(7), =
 0,      BIT(7),  0x4, BIT(1),  BIT(17), 0x6,     0,    false),
> +       [RK3576_PD_AUDIO]       =3D DOMAIN_RK3576("audio",  0x0, BIT(8), =
 0,      BIT(8),  0x4, BIT(0),  BIT(16), BIT(0),  0,    false),
> +       [RK3576_PD_PHP]         =3D DOMAIN_RK3576("php",    0x0, BIT(9), =
 0,      BIT(9),  0x0, BIT(15), BIT(15), BIT(15), 0,    false),
> +       [RK3576_PD_SUBPHP]      =3D DOMAIN_RK3576("subphp", 0x0, BIT(10),=
 0,      BIT(10), 0x0, 0,       0,       0,       0,    false),
> +       [RK3576_PD_VOP]         =3D DOMAIN_RK3576("vop",    0x0, BIT(11),=
 0,      BIT(11), 0x0, 0x6000,  0x6000,  0x6000,  0,    false),
> +       [RK3576_PD_VO1]         =3D DOMAIN_RK3576("vo1",    0x0, BIT(14),=
 0,      BIT(14), 0x0, BIT(12), BIT(12), 0x7000,  0,    false),
> +       [RK3576_PD_VO0]         =3D DOMAIN_RK3576("vo0",    0x0, BIT(15),=
 0,      BIT(15), 0x0, BIT(11), BIT(11), 0x6800,  0,    false),
> +       [RK3576_PD_USB]         =3D DOMAIN_RK3576("usb",    0x4, BIT(0), =
 0,      BIT(16), 0x0, BIT(10), BIT(10), 0x6400,  0,    true),
> +       [RK3576_PD_VI]          =3D DOMAIN_RK3576("vi",     0x4, BIT(1), =
 0,      BIT(17), 0x0, BIT(9),  BIT(9),  BIT(9),  0,    false),
> +       [RK3576_PD_VEPU0]       =3D DOMAIN_RK3576("vepu0",  0x4, BIT(2), =
 0,      BIT(18), 0x0, BIT(7),  BIT(7),  0x280,   0,    false),
> +       [RK3576_PD_VEPU1]       =3D DOMAIN_RK3576("vepu1",  0x4, BIT(3), =
 0,      BIT(19), 0x0, BIT(8),  BIT(8),  BIT(8),  0,    false),
> +       [RK3576_PD_VDEC]        =3D DOMAIN_RK3576("vdec",   0x4, BIT(4), =
 0,      BIT(20), 0x0, BIT(6),  BIT(6),  BIT(6),  0,    false),
> +       [RK3576_PD_VPU]         =3D DOMAIN_RK3576("vpu",    0x4, BIT(5), =
 0,      BIT(21), 0x0, BIT(5),  BIT(5),  BIT(5),  0,    false),
> +       [RK3576_PD_NPUTOP]      =3D DOMAIN_RK3576("nputop", 0x4, BIT(6), =
 0,      BIT(22), 0x0, 0x18,    0x18,    0x18,    15,   false),
> +       [RK3576_PD_NPU0]        =3D DOMAIN_RK3576("npu0",   0x4, BIT(7), =
 0,      BIT(23), 0x0, BIT(1),  BIT(1),  0x1a,    15,   false),
> +       [RK3576_PD_NPU1]        =3D DOMAIN_RK3576("npu1",   0x4, BIT(8), =
 0,      BIT(24), 0x0, BIT(2),  BIT(2),  0x1c,    15,   false),
> +       [RK3576_PD_GPU]         =3D DOMAIN_RK3576("gpu",    0x4, BIT(9), =
 0,      BIT(25), 0x0, BIT(0),  BIT(0),  BIT(0),  0,    false),
>  };
>
>  static const struct rockchip_domain_info rk3588_pm_domains[] =3D {
> --
> 2.43.0
>
