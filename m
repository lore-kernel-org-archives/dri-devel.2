Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB855C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 13:07:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AEFD10E5DD;
	Wed,  8 Jul 2026 13:07:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bhLue+T1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YNfbEk5R";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E86810E5DD
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 13:07:57 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668C3MEl2793890
 for <dri-devel@lists.freedesktop.org>; Wed, 8 Jul 2026 13:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WOOq+NNu+tyhPReYKnu6wDK3tTFUATf17W5IdwFPg9M=; b=bhLue+T1HZS6Z1yl
 0SK7piGEP/m4bSiAAlhhNU1mTl4FX62J6rU1q96kA8aMseiY9ZWto/Dd+0Miw/MA
 mR4PyKQbN0+ZHEnUBucu6zOkAfsXEujfYWmhI1l4vmbj7e2jH7cR7VwXg/Z3crhN
 8NMEObbUbI6ULX1L6+S8JWxbOZ31JSqX/EATTSay9ArAKJaG68hvW+2EcXMK96to
 NoyER+PjRKSJ3ycZpb7+FNwNa/8pI5bYh5dQkZYYYmwi0kkWyLAdJpvqie26YbNn
 Nx4kVOvaFr1YQ5T3Dorvfj4wI18xfQdrLiWC94ltSqRHDt3vqchC2u6ywJgry83Q
 kdthGA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9cswafu1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 13:07:56 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-73850dfc198so166224137.2
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 06:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783516075; x=1784120875;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WOOq+NNu+tyhPReYKnu6wDK3tTFUATf17W5IdwFPg9M=;
 b=YNfbEk5RLXyr9bSs1BvncEXG3Ofid6N1T/nmkhJEBpL6fBjibDzWT3QyVANeMgekmW
 z4zwHNwrXEHorkZN+XO+eI6U9AGX86xSn0/LMc6V7vDT4LEJHXwEaqE3gpobPXHuYjuq
 eRSBH/qX/rCJMv5jlknuyTjlpaiEFV3U35XesMFNv0+BBInZZhDy2wtbIJBPdTWGiXTE
 4R9H3e4+jWyHOoqJaScyA4yl1Nwwe+ZD0ju+vqPIU9vSMcDfPmUpI+/vxXg8/tbIo9ef
 c88cQhD+gFMPJxdNxPOJQxnMjO2ElT7tLCQNbIDKfVtGgXGKJLVTQGgNQsvyoH/BPm+Z
 RCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783516075; x=1784120875;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WOOq+NNu+tyhPReYKnu6wDK3tTFUATf17W5IdwFPg9M=;
 b=PbmQM/X6sCUeA6dVqx72buwrepF7oU9V5YenmCK2YyXhH6OknJCuQ2btLV8IqnAF/F
 KNipS/pGPVu+y5XUigSaISNwCM/HByMKTxR+eZhI3riXYNBGEnwN4tuhytjWi9wtsTNd
 +teSaSF8GT1xrhy7fAY4ex3SPTAw/AW+7mO/hMwLc9b1waIcp7b9/VQq4+TqCThWLVnG
 JMoWiNhOmWQ71nP5Jsp8LAvPznH29KCJygW29jQ3LmkxgSYqEU5FGvzTC4a/sMFu5JY6
 y525fSTw47o0MKYxNIOuNul3Zk6WOkBRBaEcAMHmVXbFQFKD/clYCQiFSmyncLXFFWaN
 K8Gw==
X-Gm-Message-State: AOJu0YxdK12aq251pXH6vlMD6+JQtw+ctgX7BLG/3j+pDZ6LcU+vSz8L
 0Id4K0dww0Aju0i9pCARlOhlasdRCfvdjVVhyZ82wbTPUxYJZtynhpZMhNR+VkWqv5OoQ5oc0Ez
 JoJRecK9wRx95QS8Ay2bdaOKckxlnhVAT1dpXDer/IuA2jflV7Q6f8lMvt/7s2j9f0UKK6bo=
X-Gm-Gg: AfdE7clhxNxeJSFh0lbJH4CTERLOGw2JF5DU1q5d0yl02uP5BnWjjDFopoX2Xh88re6
 ybJFHdWaivHkDtWcivnB7Hl4z2/AqUco/V2ShXAb8pVZuu555Qrz82aCk5Tf07uKWcRXUpfqdDj
 b52KOBJKNdI9+wqZTUB5nC/Bl1EfCq+UP3bMwdvW6QePqNpb+5BpubUQ5APuHeqjBu0ut+P2ysn
 qqrmhHYKfozZUHubfoUnVLYKmekeW0hr23vwsOeSjGkuguSvnWwPTb1ReyNiKXAbAFa5MURVMOM
 Dx57E+Q9r18Ih7EhUQEV1Zfso0u3BjlIKlFmObGaLv6S6romMFMXzx2KOjH9MZwXt/pdH6KIu7w
 qHC/tQMd0F8KGlw==
X-Received: by 2002:a05:6102:41a3:b0:73e:9fae:5841 with SMTP id
 ada2fe7eead31-744dff81cbdmr1130778137.29.1783516075434; 
 Wed, 08 Jul 2026 06:07:55 -0700 (PDT)
X-Received: by 2002:a05:6102:41a3:b0:73e:9fae:5841 with SMTP id
 ada2fe7eead31-744dff81cbdmr1130755137.29.1783516075014; 
 Wed, 08 Jul 2026 06:07:55 -0700 (PDT)
Received: from localhost ([155.117.96.35]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-744d6a3ee7csm1525979137.2.2026.07.08.06.07.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 06:07:54 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 21:07:33 +0800
Message-Id: <DJT7OBVIB2J3.N6UA6SLKJXZB@oss.qualcomm.com>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-aspeed@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>, <imx@lists.linux.dev>,
 <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 3/9] drm/imx: replace struct drm_simple_display_pipe
 with regular atomic helpers
From: "Ze Huang" <ze.huang@oss.qualcomm.com>
To: "Thomas Zimmermann" <tzimmermann@suse.de>, "Ze Huang"
 <ze.huang@oss.qualcomm.com>, "Alexey Brodkin" <abrodkin@synopsys.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Joel Stanley" <joel@jms.id.au>, "Andrew Jeffery"
 <andrew@codeconstruct.com.au>, "Frank Li" <Frank.Li@nxp.com>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>, "Linus
 Walleij" <linusw@kernel.org>, "Hans de Goede" <hansg@kernel.org>, "Alex
 Lanzano" <lanzano.alex@gmail.com>, "Oleksandr Andrushchenko"
 <oleksandr_andrushchenko@epam.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com>
 <20260705-drm-simple-kms-removal-v1-3-b4e1ca053623@oss.qualcomm.com>
 <1c84099b-6f0d-4655-9aea-015a821b50db@suse.de>
In-Reply-To: <1c84099b-6f0d-4655-9aea-015a821b50db@suse.de>
X-Proofpoint-ORIG-GUID: joNRKOWvPkFajImkSCmFmib2NAwnhZUe
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEyNyBTYWx0ZWRfXxNPrqiKSWYJ0
 o737HLzoFNuR/JWhqp2qjcppy/IKJdetfr4RKr2VEthVnrGKrvsFm8rTiIUrgHlLF0rme5rx8XJ
 SxFwi5d0ifIOrUMsStxlx2kpogUfjBQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEyNyBTYWx0ZWRfX1TV/jKV6cjk/
 4DctxK8MwLLsUVvJ5k6WdpBeMINdSG03PKX/GWgWIaLCx9y3XNHzlX6lsygQVLYmfI9FiKvRcdM
 hmo46xKbHdhujoQjLINsx4QvujZUK3M1YyfdUxBBZR04XllrDTQQ5UOrPMyvnVxSbljZsUP/APy
 wp2O8LNWwRqRSA2XGZvooqdh5Iutz/8GD5S9ItP2E+bWFQt7fGbPTcm5LENzW/ALmMUDCdvwm5Q
 DqAKNuaQ/ta2hR04S6vQ71nOKOvMJ3tLnL3VWqT0Lb3JAkHrk8ewCrfoC2S0b9cJ2gnus/xztfy
 FfV82abPU0sfiJkoaFvuWDVQ2wW4PlxSEGS6Pq/BDP79cwRg5Bh1mStuFw78iQB3u1xUAT6+NGR
 EuCKv5nToJKqX/tzcEH/szuJSmzjJDSE6z5+xETDi48lJM4oJ9BFOl/AyE32ly2H2tyeCpo/H1k
 lFaQgNQrwNIJ2jQr0/g==
X-Authority-Analysis: v=2.4 cv=HaYkiCE8 c=1 sm=1 tr=0 ts=6a4e4bac cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=Ilsi1XWDFcrB9FjxRIUvHg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=lv_lVlItrp0lmarviNkA:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: joNRKOWvPkFajImkSCmFmib2NAwnhZUe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080127
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

On Wed Jul 8, 2026 at 8:44 PM CST, Thomas Zimmermann wrote:
> Hi,
>
> the imx driver is well maintained IIRC. I'd advise you to split off this=
=20
> patch from the series and send it out separately. That is more likely to=
=20
> catch the attention of the driver's maintainers.
>
> Best regards
> Thomas

OK, thanks
