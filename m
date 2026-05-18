Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E1ACD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 08:11:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8770010E6FC;
	Mon, 18 May 2026 08:11:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="h87lgTl0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jsL/dAKz";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E7B310E6F7
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 08:11:29 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64I6o8M8682839
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 08:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ig94XrFtppu//nngpIGW6fYpc8m2DhYn41YRAUShq78=; b=h87lgTl0K7bH/Qjr
 TeKxslz4D4WbZjFPsNpwMJyRr3USYpqnJLfgTrpxvkfExMXB0pzEfxtXHm/Fjq7u
 igN72A7VeL3dsfCva3H07tE+JZUwa/UJASO5CHT2PnomKJwH6hwpXqmA5FKDf1Mi
 yQES5h7zpyhjBoNwb1Xnj8blBpFBhX32znZ69zWw3JzuPRWnRw9nwL5myZO+Xua2
 6VisHtfbKvtQehNQL6rmz3nCh2Oc4KTpnvjrkOhT8GPJmyEntxQB4o/dJa7UPOW3
 lo+iFa7lObEOaciadB0cOXiBJHFqE7hoDSOhEW2iUpFTcBkw/2CpuXOFO2ZQA0qY
 Zdc8dw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6tvcm8en-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 08:11:28 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50e5d7f4b63so5529931cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 01:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779091888; x=1779696688;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ig94XrFtppu//nngpIGW6fYpc8m2DhYn41YRAUShq78=;
 b=jsL/dAKzen5eqeBT6uHIOAfKTowepK2G1zOSU36AUq6oh9fwoPRHvcVq6nkaa7DXwZ
 mBPcrvmE8R3GyZrmLFfEUk628S97DGTkaZSTnG91GLLE+knYPLEXFSJoijIe9Y9nalmC
 UZ+vQ/yOlZWQ7l55YWMoMcnBVt5Yli3S2wHq+3vupIDMu/PWY5vl3Uv+cNxZEbXF0wQC
 AdkWTjwGxAiOCN3tDpp1k9Fd/UnFgeF61tXyx9l/BpmOLdlOUtYordBGcFq4skF0KTkL
 dWkCd89CA1qIPz1b4dIS2Z670XhviajZ/M1ip9OT+7wDKGDiWq++sUIcE8lY240IFeoO
 31qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779091888; x=1779696688;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ig94XrFtppu//nngpIGW6fYpc8m2DhYn41YRAUShq78=;
 b=L+5CFyhCvj22p0lw7qFIHEO4y3WGxgsMkhj7HabkVMGZB2uu+bjOJ8Dn980cQDptQe
 O6efSTyQgBudSEgda4P2gvRzOwy3GU4z8F/DbafsUI0+sdslDgV618PhSUypqim/a9xX
 4fpI6DSWRVfk6lxZWu16BgRf2aIXSMIF4LNm0C7bww76DsIK6C5SVc+K7Yh+wuuHlTCX
 mRcEOovcgtZzAcV+kGLxJ979PilPvQGi3e/hrbofiZZfL+vask8tKfTurl1h5SSx5UjB
 QFgWRcBgkGoKV+xpKkMNkQdTgsQWa9Xztxv6ZgvcEw5LJY51Sp/pXX6vhdkLvq76R/7n
 ds/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9zzmax6++RhETdp27l9J+ZT72sCfSU0idlbzuzdNGtkvCmaoOxo2VpYQMT4DGbPnxsmXAJn8la8mE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+0N/A8oKyCrO5fENHMNFgt0qa21DQgSjhZ9fKwXdDE2hdoGIm
 3bWmAlPbBzHfj7u3Fqj72tnWUpgLXbnyspFe2wDivp9aUdLwFwZPh4Pb4hnJ/lzfCB6DzHZFKnO
 nYAGmLJqfYfCnwWZS8Sb4FRBSyiZP4XTTaBFwShq2XZ1rKBRvKoHVzglqpLuTc/sSBufmZDc=
X-Gm-Gg: Acq92OFNHRqvGayeJ4X8jHUjJy7IY78rrRUCYgmfCCd3lZgk0UAPAcgAwu58eLxmzBy
 12bzTNqs+dqAtLXA8yzY4dsT6YXAmuRh5D9H/UzoUj5DTkHxQ5053BAlfieBQGz37dkbQ0nGQr3
 /8JczRkbjXBQxsJqhZU8D/BTt154VeqdMis8IQDCrowMzM4NAA1i2oQpslf9cDVmaBSasbNMbp7
 QCWgeBAFNesxrx3P9uNobxOzkAZrDDwUy5AJ3jdFvE5qdIsHEiAB1sop5HjahXADzWJCJBrPO4i
 806VasP7rC8cOm5PmGhSfbBpw2zpY2nLTgn1oTJbaJMH0pBgNRMxofwj0GfiKtZ6/phTcJHWabm
 1g7l2FHwdjGIMFFnEOOOb4Ie9/2YuZEBsdUWaH7Tfp+ePgaTCUHbgih0zoDxqs+lqCS4jaoFMl3
 UC/7MupvMzszSk4A==
X-Received: by 2002:ac8:5ac5:0:b0:50f:bfe3:a04e with SMTP id
 d75a77b69052e-5165a26ee80mr148683101cf.7.1779091887658; 
 Mon, 18 May 2026 01:11:27 -0700 (PDT)
X-Received: by 2002:ac8:5ac5:0:b0:50f:bfe3:a04e with SMTP id
 d75a77b69052e-5165a26ee80mr148682851cf.7.1779091887189; 
 Mon, 18 May 2026 01:11:27 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bd4f4e4e28esm520966766b.48.2026.05.18.01.11.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 01:11:26 -0700 (PDT)
Message-ID: <fd2f6876-9a23-401f-98b2-68ea9cd0e054@oss.qualcomm.com>
Date: Mon, 18 May 2026 10:11:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/msm/a8xx: Enable CLX feature on Adreno X2-85
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260516-a8xx-clx-support-v1-0-62508bf651ac@oss.qualcomm.com>
 <20260516-a8xx-clx-support-v1-3-62508bf651ac@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260516-a8xx-clx-support-v1-3-62508bf651ac@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 96bqVauuZ9O2EEAWhvxEbPhYVkUJ81fn
X-Authority-Analysis: v=2.4 cv=UIDt2ify c=1 sm=1 tr=0 ts=6a0ac9b0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=TDXYLTSiAN9VwpVo4wMA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 96bqVauuZ9O2EEAWhvxEbPhYVkUJ81fn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA3NyBTYWx0ZWRfXwkQmpxxwTNxL
 fu2DKl6PDrMCSJ6gBMnotZ7WeJLxMuTPaSjs/gJGdfl9qKZpunOyDNgM1LlMEK8DYMZ7qIW8QQU
 f9MY/+q9R0CYnZ0Om9NAI8OBEamsrAv0iMqNp7uBFhti2dcteSNJk35CUoiaytZ3zHdiPuxI+wU
 pvszOixQ0eDl549TIh6vcPScNVXEnug1ouPIFy3Z5QBzrC9TpVMjnxgqjj6crr4w/YTQYQh+0b8
 M3NcTmGRtSBE4M/8bZEQvPX/5WRx3y1ioTWg5hBi08CQ363TW7je1Lsf7PvZmmkeFGmhf1DCoid
 9NN2wpIUuYtZB1cfq+RhuZuKNMuF6EBDaB4HQIdSgeNb4ZEHmnYWZ/O8TVaMCpiv+mD9NTpxOqH
 mZGHxA+TEb4Vg2LDc9VA9VLW4XQPQDTfhnSjI4SDQYXrHdSVnTeDUUEnJkr3q0DC3iGK+KgtbCb
 a4NAF6FDfTDVW3pKngA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180077
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

On 5/15/26 10:07 PM, Akhil P Oommen wrote:
> Add the CLX domain table and the IFF/PCLX limits tables to the catalog to
> enable CLX feature support on Adreno X2-85 GPU present in the Glymur
> chipset.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
