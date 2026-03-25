Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EB5103A999
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:31:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AA5A10E691;
	Wed, 25 Mar 2026 02:31:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MKyoclZv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ODwn6ifO";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A32310E691
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:31:09 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OJCdZ02973641
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lgdUZ766qP52UFBenu3tcqJRT9Q2UWW8KWkqpgksoP0=; b=MKyoclZvBrGX/+uQ
 xdHFhtfzk4rS54TbFMjpfof88/Bhjrz7jDCFL/56uH5TUVDbK8wWq2WbGQNyoiq0
 KZHXf6FtNV7bJoF2/CM1r8D1AjqFM5wI4NefC7MYVwKwxQEqC6NypiLdvHDyWhhC
 C7QtAIIKt5jXL3p5/AEltXt8EKiY6PS60JCVQSZ66TUKJtiKUSWiJKE8kmBQDLUH
 JplSrVE9xWNjJvj/Mzo/5LI6TTX+gNBBevqLT329FiW/N/gmcSCONxZiwwPk6dqG
 msImHCqPSsdeeXedeW46InyIqEokOCfM8xuxEx2bZ/ZvCbfSb4BUPrkOykJ+EJtx
 Uu6SNA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d40f4h4rw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:31:09 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b2cbe7223so106267351cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 19:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774405868; x=1775010668;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lgdUZ766qP52UFBenu3tcqJRT9Q2UWW8KWkqpgksoP0=;
 b=ODwn6ifOVGVSahdQkzh3VIoFnVfdfuzS+uNbzPo+t6Hw7813P/8O65lak67Un1Jsy1
 k5tJFtghHnO7/8noBUMX/+iYaSrHY0hX8c8my3n2ZU/XZkTh5oxNrkvvv0XIu3zk0tG+
 H7SF7lQPfdPdY8GdNZEQ1fDafw0wcdE1B4RprbylsTPAHgYEmaJsxP7VukIG6mja4ZNP
 NvtkXBfoh+YEyMJs61YYzSkF6W58aNWWpZovPrfWJq8UVOf+Uu7XRWKKw7JAagCDXIRy
 I4+aBQ3YnSjPy5aTR287Gmh8bftFGGE99iUlppMP7KoNYsljwSX4jOBRjiSML09RcyLL
 Ak/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774405868; x=1775010668;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lgdUZ766qP52UFBenu3tcqJRT9Q2UWW8KWkqpgksoP0=;
 b=PfnmLfFCeHDH/225RvQ5vtbtT4PUvSTSEX+MqGBsTypors9quVhjH9Lup7RUng3SVv
 Bb42dVxX/6Bh9kB1bRoz2162VzPLdNMAbz8UgoaYbyajANLZx2hO5JF1Dp8tYqirjkoC
 y9ciX3CpNS005ntNphCd5cMXJaIZJYT0Zpvb69rLCcAjT5Jo+KN+Zl+XgyyJ3elZ0rKX
 uasOCfl5cPcgR2/LGmjozGE2Y7MsinrBW2cvNtX/OPjm5+hR+SInmvtKqHHtIrRbD1Kz
 ma+juzKFqOn6KzeeQjh6R8OkrBqzUZryRXp3iWhEiM4dyAMf1kt0eVaSMOFfVxSjCdJv
 4ARw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpLTaJQ3eVP1oF2nyPDx8OrKuLyLJ6OXrUTYAJGgC5P5ZeBqGYs0TbjUNVzuPn87HPATKzy3YDOac=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/SSI6kBMbUKUF0qxDWAHOb/E5R9tGM7b+4a2NGzwdlvecOFbw
 v2ulDpqsUdLFaDSmeZGnGb4O9WUX6mhvSRnqf3KOibR45wyOZ6Sf+8/8xPD73oZywZQRDdChvZS
 mXNKiMaRMpUAMHHs8ngXLH6hbqtsfnoJxGa5h66+CMO7Zu1hJXVOFf/GENbeH5bwfeyw2PMI=
X-Gm-Gg: ATEYQzzuJZz8P5DLEuUiAHkXEVRihohTAaC2yx5h+bCJrrhcH3Fktc6xHbVV8z/wHxF
 RE4rPzu6+Opb2Ge9t40c2lmLmdsg/0QxPL0CgYma+g/k4/ROUWYyVJLGy6coOeeTT9yQRYQAggr
 fgn/CX9VJiGvxK/HibPGDVPL9kY/Nr7NLYpWnIfj5MZttqh9mk4KOdJ7fqKZRQ1UTw8992zcXT7
 c9JnFoPeYihW0+KpcdHZToW6KLFNl5vVDe3Hp9MgeKfIuEIF6liNgjt5wCG40f+KjK11VhX295C
 2aiih7Hf+XOb9099Oql8TPFxpkKR0dXmRu5qaYllMfB/ucuIpaF/6peHSSOku8kzs2GVm+7n0U5
 asYdm74qPwpXmRFUfUO0ZnKFOwPhypQ2Dcgxgc6VlAlcP1EamU/nVv54bVnkEAyu5kTOPiX5sx9
 RsBwMHJTD9Hh5UvX14kQ9jkDSIQRIHiuXL3d4=
X-Received: by 2002:ac8:7dcc:0:b0:50b:2d05:368 with SMTP id
 d75a77b69052e-50b80e51e70mr27581341cf.42.1774405868545; 
 Tue, 24 Mar 2026 19:31:08 -0700 (PDT)
X-Received: by 2002:ac8:7dcc:0:b0:50b:2d05:368 with SMTP id
 d75a77b69052e-50b80e51e70mr27580941cf.42.1774405868006; 
 Tue, 24 Mar 2026 19:31:08 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a285206f68sm3412014e87.52.2026.03.24.19.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:31:06 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Prahlad Valluru <vvalluru@qti.qualcomm.com>,
 Vishnu Saini <vishnu.saini@oss.qualcomm.com>,
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260316215920.1993390-1-arnd@kernel.org>
References: <20260316215920.1993390-1-arnd@kernel.org>
Subject: Re: [PATCH] drm/bridge: lt8713sx: avoid 64-bit division
Message-Id: <177440586544.1663773.9665237848645647418.b4-ty@b4>
Date: Wed, 25 Mar 2026 04:31:05 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAxNyBTYWx0ZWRfX949zGZkQA3YH
 BOdjgIXA6YBL8OWHa9tDZGY+bwA2c5t4Pu3j9vmpXVv/BKHpOSHZTj9WJ5Rypd84JQPX+f43eCF
 qsSsbNOFcq0lBNeBh9u/jao1rfextFn1VSp1JOASrPDlPpldameNgtQ8DveTkjClLz8brXdLzIF
 pRIB56Vg8PUHSFSRpLU09JJJPvU6S5wnm7iJLuA50J6cOL7+YTiL1xFgNTKTGLZkAtg65wOsWzw
 87PoK2oNUQZuFF7/PRolCWoZqthARDM495b2UKOujhhd0F2smrMOZ7AwqL//a/r7vslpXp9wupC
 1CYBJZW3E4EPkoon/kn+JnbO80q+Sq8DfbR9QRcf+OrwEIlfvOpfyiKgQqWkt3uY9V7w9GEWBBu
 +JFNIgi82QLUCo+kuMSm1oTNENY9MB4rAk9NKD1t5NgWjoZJRCOH/JlA7nEsO9FVSV0X9672PMw
 QXhuoh7Rw6yS8HMcwnA==
X-Proofpoint-ORIG-GUID: KqBYIid6UnQhMlzyCwwKwefHjHO56pwJ
X-Authority-Analysis: v=2.4 cv=Cd8FJbrl c=1 sm=1 tr=0 ts=69c348ed cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=BHw0BEnDFb6jVTUBZTMA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: KqBYIid6UnQhMlzyCwwKwefHjHO56pwJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250017
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

On Mon, 16 Mar 2026 22:56:32 +0100, Arnd Bergmann wrote:
> On 32-bit kernels, 64-bit integers cannot be passed to the division operator:
> 
> ld.lld-22: error: undefined symbol: __aeabi_uldivmod
> >>> referenced by lontium-lt8713sx.c
> >>>               drivers/gpu/drm/bridge/lontium-lt8713sx.o:(lt8713sx_firmware_store) in archive vmlinux.a
> 
> Since this is a constant number used to divide a size_t, just change the type
> to that as well.
> 
> [...]

Applied to drm-misc-next, thanks!

[1/1] drm/bridge: lt8713sx: avoid 64-bit division
      commit: c196276f7809ac89743e6de61262c1b4b84f78d0

Best regards,
-- 
With best wishes
Dmitry


