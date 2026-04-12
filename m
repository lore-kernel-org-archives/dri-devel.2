Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC6FE937F6
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 17:57:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A81B10E2D2;
	Sun, 12 Apr 2026 17:57:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OP4YViH4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ePHe5tcR";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E40B010E2D2
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 17:57:09 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63CE5kaw442173
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 17:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 thQtqmVfOFcBFGUwZg+zw5IjO7y+NzSjPPe7a716jaw=; b=OP4YViH4gAd2pwHt
 tCOBnwBeu4z5tWAGGf5hAjQhsDSlroquvq4gEIxfEbAa4AnikdfrjQWjeLITouHc
 HiR1zhvIhsXpvEAqxgPANua/Ws8rZzmSJD6zpX3h6wm6uLOCPlIKxDyB8jv7Ey8S
 LQLB9VsgZmJFrXd61XneBjuiAPmECCkuOtgWXsIuWpmybpiaWbLhS925KeFP6YFO
 AlsmhCSMC1Xz6ZyfXgedrg8nbunSYnNM1kMlRGWuvKU7zwpzKJfTtm8/mTHdV9I/
 eZEcDezlQMIw/xEv4ofenUsjDerIFBIB9wNOYNZ+qSrVYJ6aya1LwFNTpFek/5wY
 /woqLA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfevtjsej-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 17:57:08 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-358df8fbd1cso3971680a91.0
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 10:57:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776016628; cv=none;
 d=google.com; s=arc-20240605;
 b=kejfdQIu6y4q9sJANl2Cfk2E34mk/IfuLO4n8Kyrof4JUWqUmeYYBgcQ2uIZWIvNZE
 N1nGGmDGcm8Puf86Nxii5LR+1MYdBv591WnnbnsA2kGPhmueQLuBZRfi1RUvsf6CNKM2
 OBv2mWCFG9SWFvHKjMEfXkIWbNTeV8Pkcf619wS5Lxn/TdXQ24nUv6tI3OBkY7XoIwaM
 OCqcBG//tnyMnV0J+mjRTARPJb3adyTwo9qHKt4D63G7MZ/nx9joqTqytMQoGb150Z9h
 Vvpl7gfFvaCDT4aRttHN59wtfRd3I08gb/AvddTSpJ1pemqm4IdANte67R1W7r/WEpGq
 6NVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=thQtqmVfOFcBFGUwZg+zw5IjO7y+NzSjPPe7a716jaw=;
 fh=PALgaiR3tv3yOaldG0jHVN2BVFGZD9wLuiE/ush9tso=;
 b=hePVFCpoUYXxlFDz2Jx6xTqNqJcP8LKcoWzu9JP1XBRehCXGrEmlCK3AHNsTXEQxvO
 3fDfveIGCmubNFJwFNjPe+zttm3rTMRIt9nSLYctrZYvMByy0hOkWsocKl/7ulQb7Y2x
 ixTRE06djOG0x4+Qy4O76hHq5/J5SvvW+c/zZlZ70aiiHJZGWtabLBe91OVVifZHahmD
 137ny/yX+BcfL0sXr5IMgDh4vVJK7yU6dqnwj0KQ+MdCl50CBgCunDpt0PXT1dHOKkas
 HxoDnROMiz7FkGYAC0fOIcDq6oiSlBCBWR1RBqX22LH4n+eL7+5+q1n/+UXq0AuKxfGg
 wbjg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776016628; x=1776621428;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=thQtqmVfOFcBFGUwZg+zw5IjO7y+NzSjPPe7a716jaw=;
 b=ePHe5tcRSjQwwi/qnuCs8PKEUnI2iQZi1lqMOznMzn+iYN2WYajsdwr0Aeq0hnvbAA
 mHAqwTyL/U/vryGKxB5xg65uChUOQseTpTif9sJAB9hKHrZVDtPsN1RZvxwDmzASswpt
 2oC0Wxs+OI+ZF9z9oyAe9drn202rvbooUgpkTawXP/Okf3MrIef2i+NIm7K2F1AipeL0
 BGoKeULroVVcwNvvLNb8iWt/GrvapQJNduCKD0oCodrc8CWWMewqA5wJ9jDzT2gz7vmn
 9c+aWoIJ6TQkAIoOvlRGUlK8wrPEYMcT9ILCBa1Udx0UgNGr0YEcwI2Gd66j/0MQYED+
 9uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776016628; x=1776621428;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=thQtqmVfOFcBFGUwZg+zw5IjO7y+NzSjPPe7a716jaw=;
 b=D60uzmGnN/s1ZeRLlblC35BKuKzq41+9d0XZgbMYepYz/e2ywHix1EyfvYpm75l4oL
 cMe1LqQ3xh0mnG5PvA4ZBQcXcX4WlUnWQtHp1iyrWcca/RBoYhS+RAcA07lCgxn/HWw+
 cmK4tb2tF4Smp7Ff8dM7np/w1U/UIgeweBX4ozB9jg1IEYH2ILzRyGK3nwrZx0v06JAg
 rHz/q5WIF5m5Y/rL1QBxZfyUa0u/NGOOXTdHMmSgTGR0cKZYQcXFGwwmpGtVd4PXp6X9
 fBc4Yy0ZiJ+FeuyIof19JWaHXAXoK3HpPoAF66Bzj/TIYtiRlu79hQq9MG53oXWlRcjz
 JV/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/61exmEL/JnmGutohlkJGjHia/8pFJlMqvoZ70H30QLovDxhySjNhvTznVXGNAU0eDlqmqFLg51bU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyMrrPQO3GN1eaDZtpXhcZT68MyJDrsxCo+s6VFmpWTpNYkpYDQ
 WeFQDNxhDPcLudEY6KZssp0syJ8NlF179rK5rnmRR9ud2TGQzwSO+xi3ilEen2fdkIHWx7iAKHU
 V0kRPNizCHvmkiCL/XZpoHxa+E+vJmXLy4FDnVB3m3QkhJPZlggy1GRm9U0VKDzxOt4yRFbr8n1
 WLcfawzOe/Vycx5R4KTOwCyLDur9di1QMIEi8LZLzqxd/F0w==
X-Gm-Gg: AeBDiev+8Qr9klZ6jq6asqH9BjUc6GANM4VUh5tbl7VJgwKdid+ifbysNuSmyHU8awK
 p1O8HlRotqZDzca+O29lSAoF90mnHxpuJ0x7lfl0xXOOkwP/zCvov+LjwjRh/erRRJMarUjIHJC
 cWTucidB3rylmiJgeytfyejnattEVEESMPbbR8InMg+zee6BlpUWIPji0KinByXJnylML+E7vjZ
 IgC9L4=
X-Received: by 2002:a17:90b:3c48:b0:35f:b9ea:8fa5 with SMTP id
 98e67ed59e1d1-35fb9ea918cmr89838a91.20.1776016627721; 
 Sun, 12 Apr 2026 10:57:07 -0700 (PDT)
X-Received: by 2002:a17:90b:3c48:b0:35f:b9ea:8fa5 with SMTP id
 98e67ed59e1d1-35fb9ea918cmr89814a91.20.1776016627186; Sun, 12 Apr 2026
 10:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
 <20260401-waveshare-dsi-touch-v1-14-5e9119b5a014@oss.qualcomm.com>
 <CAD++jL=jUd4sQ1bhwcBRYpFFApP6vdJw2BoQwxoWShUKdEb9oA@mail.gmail.com>
 <z3obsnbmdvvlzs3cxm57osbax4ivg2zq2zk6xgp37n4hni7y6i@smwn362nhn6a>
 <CAD++jLnXJKKv5ghRnCcMTU9g984seJAMHyL6VWWV0Bv+dv01wg@mail.gmail.com>
In-Reply-To: <CAD++jLnXJKKv5ghRnCcMTU9g984seJAMHyL6VWWV0Bv+dv01wg@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 12 Apr 2026 20:56:56 +0300
X-Gm-Features: AQROBzBYY7vv1cLFhlrg6piWW1-Z80EzCE2Hx7Xxi4DegOE8nD2ShaZfoDVqJb0
Message-ID: <CAO9ioeUAqG5uPs97ZAgzEfQVTW6OZWsCpAfxmDP4YUhjYt8E1A@mail.gmail.com>
Subject: Re: [PATCH 14/19] drm/panel: jadard-jd9365da-h3: support Waveshare
 DSI panels
To: Linus Walleij <linusw@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>,
 Jagan Teki <jagan@edgeble.ai>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=RYWgzVtv c=1 sm=1 tr=0 ts=69dbdcf4 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=xwq5OVEf12Z6bUwLnC4A:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: soe0SLLbP-l4ZQ9oYgd-7oFzmYzlvD_o
X-Proofpoint-ORIG-GUID: soe0SLLbP-l4ZQ9oYgd-7oFzmYzlvD_o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEyMDE3NiBTYWx0ZWRfXxy8SAoJU8Gr4
 v1+TcWOFAxYrucpVOrufVEmOYtRnqL3x5+5dAEsXxxQ1EY5zG+0GR+Hc/Z6yGViJXSwrSrD0rA7
 OpJrpogP4qKZe34GX+44V4kzNY97VChoD90lHRkH6LiimGUXY4bSS8YsWjXrfLhBM3wz3N/y+lK
 cY/ZwJ8RUxV5CYj20QvAtC7Ajnj7CbhwwZAla9kgNSjjPKl1O/6E8Gfq/tMLj8gS/PMWiou/CNF
 nhjXS9kjDPu1bzYZQ4sd/0yKQtoE8xi3bENHcvolVHUH5cBtYT580A3uLsu7evP6l6TUKHB8WuH
 Ei0OZIHxIaz0/FiPyS4yfWVKCqHKM4W3ECLBOEQoIkpYoK6+K3Bwuklcb9IlqY5uGEKGCa6vAAf
 8JKnSK3glmJc1ViumhhunlYmv6XMdUB3aMXzOVWupihF07RsLQA26R2opkQKJB7lByirG6my85B
 z/iuheWZhz8YYiwyvnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-12_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604120176
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

On Thu, 9 Apr 2026 at 11:50, Linus Walleij <linusw@kernel.org> wrote:
>
> On Thu, Apr 9, 2026 at 2:49=E2=80=AFAM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> > > But there is also one more thing, this looks like a big "jam table"
> > > with just register+value tuples, so construct something like:
> > >
> > > struct jadard_jam_tbl_entry {
> > >         u8 reg;
> > >         u8 val;
> > > };
> > >
> > > static const struct jadard_jam_tbl_entry jd_3_4_c_init_jam[] =3D {
> > >         {0x00, 0x00}, {0x01, 0x41}, ...};
> > >
> > > (Ideas taken from drivers/net/dsa/realtek/rtl8366rb.c, take a look
> > > for code and all, you get the picture.)
> >
> > Few months ago the code was moved exactly in the opposite direction. We
> > added all _multi() functions and made shure that the code is as
> > efficient as the register tables. On the other hand, having it as a cod=
e
> > allows better control. E.g. handling 2/4 lane case would require extra
> > hacks to the register tables, while the code handles that without extra
> > hacks and without loosing effectiveness.
>
> OK then sorry for the fuzz!

No worries, it's fine to explain it (and also sorry for me not being
able to answer your other questions).

> Reviewed-by: Linus Walleij <linusw@kernel.org>


--=20
With best wishes
Dmitry
