Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E908C5DF70
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 10:39:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D556910E4B5;
	Tue, 18 Aug 2026 10:39:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YWOPQPWa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iYOXWBFs";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8305D10E4B5
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 10:39:06 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IABlIB599528
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 10:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QVmUxPVCbmg7yj/NE5q4TGeDCNpmSHEyTY00RCbjGKQ=; b=YWOPQPWaEm1jv08h
 CKnGvBzjon0GIdq4bYTxLHNEWoDWTk/OsGdV/XsdpUDR+VYabd/E5wXx9Coc1CAJ
 4yjrmCSSCKMHJeegxbjBwFfZ7jHv3cfaXmMePmkOPJaPXblw1KNQbYGIhaQeU8f6
 aQOvw640NU5KqheISN0OjcLu3GKO+WZAMOoJzpIygSqIOW/E/vEWcrsWcFaWJEqW
 VefqWJLsN25U/aR21ZpSJfrfukoq6yevsqUOwuo1MdTxVlQzA+67h0CIcpYV0Q5W
 iy+8n4ApGZkD6zuiLqaImgCKiI7MDjPyqmNMo7koNfN4jrKp7F6c6NzNKotfKw1f
 62RW8w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4eqtsvt3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 10:39:05 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-936bd9b045fso4321485a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787049545; x=1787654345;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QVmUxPVCbmg7yj/NE5q4TGeDCNpmSHEyTY00RCbjGKQ=;
 b=iYOXWBFsq3U8OvFOcckDBSTZyCO26hc2Ugdq2F8rjfT+jI3rDiBTJEhWKFxXUhEBEJ
 5GbYiQJyypkB+JymDQHC8dSbbPKKIZbnpkLFA3QTjG0TamFk0h3RwAsLadVq8DK+1YXq
 zQ9veORigAeGlvNY/HahHbSOVPsPlPX3JC4FBjBN1DbJbFtMIYr9JYLhzxQk8sFkgl1A
 ysEhRKv2I68BK+o/JwCM1d0X5b5tU1g/oFrt++/RfrHFDLfpWHw/xZqUo+bVuGe6Sc+t
 9KkI5lLvbwjvT4igC4uyk5v0NHZlEI8AFYUd30vNTB7aAUvmww9K/yK8loaJifMeevV1
 tOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787049545; x=1787654345;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QVmUxPVCbmg7yj/NE5q4TGeDCNpmSHEyTY00RCbjGKQ=;
 b=NKmjVLU5/NxL+jibdt2gQJMsV9jJ6HuuZKAlv2MS3ebKPOBlUiAxtPeL0yJ408gNa0
 Eo9LeZan1OlDCv/sfE3l6Mp0xFtAhDtzqMc2SvW/yuQ3Q672Qyhk/BLwhJivpY8sKXMS
 Dh3TxKPnkftSxBB30PxBtlltF3+aAMekYJ5AYBF2s1MlTx7jg06S292TnR4eg1FfluNy
 IMi0+HfO870IYknn6Kg2mToKTLE5pFEQFcDzzTeAltckLjZa3bzeC1JCjs/JNuGaP5EZ
 qa1sFh7at39Hl6J03kRafbhE4ail1r30N6v5kJYMTp4d+Ay++JUSkWISQ2bFk5w/RRg4
 kHDw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrq0RWOCB3G9ZOJw0ii1sbF/ZsO7Vs2lBndbl36MU+ffU2xvR2vfgNjG+yO9x+S/Jon8BLplXx9sBY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxR10Jx3bRHeZKwS27O4OrSSc1AA3gejRgpr2LXTbJwkcfHiOr9
 0bj1BEJC0BsNT54Hp8C/fzT4yqezRQgBskVeYr7nPCt42eMQm9MDL3TPZrKgdl4PW9f6BQEphId
 4lC12plKIuIe/fUmZDMng6Y5xQjpejgYHq9WoOLB1/Tol4HMp1mJ41MlfxhoFDoGeOEuYSyk=
X-Gm-Gg: AR+sD13ZMFOf+2r9YU4Avc9qDZCkRolrmQeb6wn8MqKKinqeX9IXkiHpKljWLwZx72A
 BhW8zrGz+zel0W6f0AcszUleD+J54ZkWkWoyA0QE5iHtj8IbHV3QQDQhcfY9hNe6mTpZBzkEJ+Z
 tn3wckl4JTyaPGHPbT9O0jyHwk9ig6X6gNoleJjTnAU1iMcDPPerpgYZQH37WyEYxGElFNkCtw9
 KJrb1S/D5pteMM7Fjg55L0YBYitcK1+jg2OJwr8Ut4LDIN3sitSyhcq8BcSTCBKdajkS54AyWWK
 alJUKUHJeeLx0GAPdnLYW0JKqM+B5W++q8Mru5bn9dZU+fZ418n44E96F1wVUUpj19H3NXwURgs
 oA8xpejHKjRBX9vMH/OMIEHwk
X-Received: by 2002:a05:620a:2a12:b0:933:9bf:cc73 with SMTP id
 af79cd13be357-936d2357528mr2423696685a.3.1787049544501; 
 Tue, 18 Aug 2026 03:39:04 -0700 (PDT)
X-Received: by 2002:a05:620a:2a12:b0:933:9bf:cc73 with SMTP id
 af79cd13be357-936d2357528mr2423693685a.3.1787049544119; 
 Tue, 18 Aug 2026 03:39:04 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c217fe6aa89sm166585566b.2.2026.08.18.03.39.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 03:39:03 -0700 (PDT)
Message-ID: <9fab8686-d0fa-40df-a6d0-75349861d78a@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 12:39:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: glymur eDP PHY (v8): link trains only at HBR3, all lower rates
 fail
To: Jesse Casco <jesse.casco@gmail.com>, Abel Vesa <abel.vesa@linaro.org>
Cc: Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, linux-phy@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260808171321.133028-1-jesse.casco@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260808171321.133028-1-jesse.casco@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA3OCBTYWx0ZWRfX8C0WpP5LnI8R
 EMJAznGywvmw4+eji1fZCdZ2v8csZDt7ELNHmcTci1gkWBpUovBt7aqa6av1mC+B5sndQ6oQegi
 UYRt3uzqHm+PqSMxwXp42jFGVxcUXpc=
X-Proofpoint-ORIG-GUID: 4r7GYtL2wtwDUPLzFWvexX1PGAV_v9Xu
X-Authority-Analysis: v=2.4 cv=UfFhjqSN c=1 sm=1 tr=0 ts=6a843649 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=nkM7kGyF-zu4sKUpaxcA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 4r7GYtL2wtwDUPLzFWvexX1PGAV_v9Xu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA3OCBTYWx0ZWRfX+495SIv1n/6m
 yJtaAhhsMaIYLdOwHE5ml7L4bYYtUw76BigYRquL+QLxTqMf+UUDssdPjrxg8EB+u6gT4wyED2V
 HsAmcJI6csmUReGtGc7LBnGBj/jGbIGO4vijBbwa49dwjur90wxnp5UmGsIK0PTfHTN7fPxcTuV
 qmEDzJwYwivLW4RmxXfLFts5uFc9VWbSQzSbbYvw8wl+uK25hpBXcGyE0JM/DOr+uXnHUlbnj4D
 IAhqZlJWLBLNIEDPKRxfAld6NPHNQH8KYlO9MY0m+9lqi8HDye1J0BLg5OfiJ/IH1AGGLNyv/MQ
 wB+ZOCYGA9jbBudGeXDT24aw/nkC0mHLMKObCJrKimsMYm4XVXccrrO93USP1MpRYM/mT5Mfq7Q
 qobEVO6RjOzgGlmxv01Aqz2x204R9LxKfZFLDxzXpUnGpH1s8EW3tv6YKPsTkf7UXSxv9FLGAJe
 MHIZoa4LLJdYAviaGkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180078
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

On 8/8/26 7:13 PM, Jesse Casco wrote:
> Hi Abel,
> 
> On an ASUS Zenbook A16 (UX3607OA, Snapdragon X2 Elite Extreme) the internal
> eDP panel never comes up on mainline. It is the link rate: the v8 eDP PHY
> appears to bring up a usable link only at HBR3.
> 
> Tested on linux-next next-20260713, next-20260803 and next-20260807, where
> phy-qcom-edp.c is byte-identical -- so not a recent regression, and the May
> 2026 series (eDP low-vdiff LDO config, unified swing/pre-emphasis tables,
> eDP/DP mode switch) is present in the tree tested here. The sweep below is
> from next-20260803; the machine has since run next-20260807 as its daily
> driver, where HBR3 still trains every boot.

I mentioned in my submission that this series is required on top:

https://lore.kernel.org/linux-arm-msm/20260622-glymur-edp-phy-v1-0-814b45089ac9@oss.qualcomm.com/

Konrad
