Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FD510F2865
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 19:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CB9C10EEA2;
	Fri, 27 Mar 2026 19:48:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cN6z0mn6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MVlB2fp0";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63B6410EE9A
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:10 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RI2Xr9890278
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +dL4YJ6d/SChfLedCdJe8nDIcKte1YxcOzhry8zQBEk=; b=cN6z0mn61b72m+zc
 /tx0RE7Vw16MQB0lUFbaPA19MClrcN/H7Amp7sTg14XnbBPEwltEMTYSphtm7d2Z
 dm6JPOHnXeLpuAP0XgHtDkYW/vnVCPMFTFpwSe3kkRQCDDNdGiZ44rfUSaxe2FsJ
 /AVWdoDgRV42TEbosP/t+JxWTm8OEPESJJQ8kYazi/lQUFCSBhPiUTPrcE4mOrGy
 onpYhqt29c7N6zBPoJPUxz8AU0e8CpS4aMihJHP3oEMdBsrIhSxI5wIlPhEzXbMP
 3LVafit9CS9n+5TiFV/tt/wP4gPMsfXZN6Yn7tqs3Dfz4IiN0Bgd4L11Y+B5AA6p
 lqdk9w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5vf6rugb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:09 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b802961ecso34154111cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 12:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774640889; x=1775245689;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+dL4YJ6d/SChfLedCdJe8nDIcKte1YxcOzhry8zQBEk=;
 b=MVlB2fp0BOSel4PQ+s6IdHfFv1KLl02CZZI6y7NkbpgAfZPLKj4uUHtR4jg2FJajgR
 guJ1jUVGfwWn+bNtjXHVfXdPjLHLsdiodhdty1GdRG+nozLhVMBdjBhFA3r82hbuOvyy
 /XhfyclR8qUHk1UujypSOrjm74EK2yAD465msRrvGntkbSG6a3bMlbJByxvrI3Xz7PKx
 enEmqRI2/rg2dtJeT9pQBYrl28mn3SqCwTD2a+1Y/Umx1EMPlkEfXO4cnUkOkG+vW9aW
 FOtX2WlWxuoGHxZ3gz9KGMu806hYrnjmAeJGUkPZ8qsLllhBAxTpmlMKq04dBN6CeS7y
 RIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774640889; x=1775245689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+dL4YJ6d/SChfLedCdJe8nDIcKte1YxcOzhry8zQBEk=;
 b=dQum+TYei8b5qGLZVXDFMMKmw9IBzbDD5wUF6Jb5Lg6JpI6o2eV8t05p63zQeB7q9C
 naoGoTDEI/9VAVcwA9TaN5+o0nchg2tOojl2Pb05Bo4HxqvVwByI/vjEij/CNNYQW/6g
 OlxRbefI6SLu+xbkYmTDTPXjxZUhR45dR/W+B0Y4xoN+sM6RufPNNhWheQ2NmCgkWyPo
 CnemqdV1aP/IC7qNDBi7HgBEcuXmuossObYFeAfs2p4yFWOQiKiPEs6HT0Q07/gHlKUG
 ia7nx68UneiiToQis7CFe6D5FdKAhdDgI1Ti3iKgIsaV0cHo93G93syOaVRpBo6lQ3Ep
 FGNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJcn+mOZ3Gt6xM1W7UtIS7SqHVTocI465k93qyvqR7a6AQD7q6FzbN5MtdKjbgu6X3VoQlNbxWTcE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw0GiZuohzU/RlpIDKH3amYicTll9goTervfMAIHKv8z00c5ECY
 qsu2kdO+CNjN2xHWrCJUe0k3YqN4SXPn+zaugVZJAAsZOG0JihnENRj2BfBBDc7Wj5C4oEtJKqS
 17+FOGq/0/VlHs82QnbotVqaamFi8l4hsw1UnqIvh8HXDS7K93UgPgmryYpxisy6k2qYJQoI=
X-Gm-Gg: ATEYQzxBglqIEEn6BBCBdDj+CslD+4sVfBZzoX/AiJQQd1ugXsIpjAe+pEeMcFqHx+F
 AbWNpozV+qAkpBrdrCKMxmdr2TDKkwVirPiFgjlWAYDlZYsqw5ojGhPlUCOXeO0F3x1q2mnQz/X
 93gipT1OyN6HPymUGNjJU2VpS6Kf9I2+ToZSWgmZvVTcLFhFOE1e+uEGV/Ij8BQ6y5kBn0WkT7f
 3xfiPYRbqzgWH1qPVHBfohKQSqowAQ2qbMnC4tG+MUVdYoHrKfkh3rbUtAHat3VrouWUpPpI0pc
 K3/PgPe/W3ovzW1MqXnBLBO/sXBUTu0KG51rhBn5f/idjkJmb6j4JSi6g4TfGyVPZQv5vC+HGe4
 wsZOs94tFQ/5pj+xJkE2jMeD0ckFiWs4G8i/SSVWy/t+sUae1TXM+UrLmXcpMMHmrTvuoxXjmnT
 Ghg76V11Z9Qnvpi9+61EQk0l4l9CISai+f
X-Received: by 2002:a05:622a:4ace:b0:50b:4922:4b8a with SMTP id
 d75a77b69052e-50ba38080c1mr54080241cf.10.1774640888887; 
 Fri, 27 Mar 2026 12:48:08 -0700 (PDT)
X-Received: by 2002:a05:622a:4ace:b0:50b:4922:4b8a with SMTP id
 d75a77b69052e-50ba38080c1mr54079801cf.10.1774640888363; 
 Fri, 27 Mar 2026 12:48:08 -0700 (PDT)
Received: from umbar..
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c837130basm275211fa.12.2026.03.27.12.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 12:48:06 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] drm/msm/mdp5: Remove MSM8974v1
Date: Fri, 27 Mar 2026 21:47:46 +0200
Message-ID: <177463970842.3488980.5562803402548499202.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302-topic-goodnight_8974v1-v1-1-e0006f7a0526@oss.qualcomm.com>
References: <20260302-topic-goodnight_8974v1-v1-1-e0006f7a0526@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X/Zf6WTe c=1 sm=1 tr=0 ts=69c6def9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=e5mUnYsNAAAA:8
 a=ttHDrauno2BbZGVTw4UA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: ZFTkdonknZ1G-xthBjIovohrn6mfeq7W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEzOCBTYWx0ZWRfX3+gKzhetY2qR
 dTBCnw+l4OPOBpgX1ybelzWbK5yFd2JdyighPv9BWXYwlg1N1dQLGPtgo6Br1EKfM+9JY21rQCw
 h/isLBoaXhGbjdzQ/4u6D+6Z6pMUkn5ZaVHf/CaiSoHxRCKKWsIkePGU2yRKF8wkyx7nABvovZZ
 TCCUBGFEKgUUpaLQdRn9gfhLgw8bY5QfYz52KSNnqYe5BroMPu4qB0qQKCnB7ZOdvP7GheaUSQ2
 jUJdE+gL5ojnKDeXr4aycCnCjgA5RAPRoiAWDEafcmMee8h0C6JRlv/Rovxck3Kua5lPT65cxSM
 9WcjbARtDMpMA8WG42hAP1KuphAI053QRSXW+ms4B37uX//gtGhzPFxO86zG854EE/oT6ZqplZl
 i86EK6SIOQ/xag79WyuyfBzEqP0r3l1avMAP+pgs7DyNHSi8uANNKvJsruCoZw0OntE2TK7j7Yl
 N2Gdc4ZsqbV9ZZIEKOQ==
X-Proofpoint-GUID: ZFTkdonknZ1G-xthBjIovohrn6mfeq7W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0
 spamscore=0 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270138
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

On Mon, 02 Mar 2026 14:41:26 +0100, Konrad Dybcio wrote:
> To the best of my knowledge, the v1 version of this SoC had been
> superseded before any device was released on the market. Everywhere
> else in the kernel, there are assumptions about the SoC being revision
> 2 or the later MSM8974PRO.
> 
> Remove the config for that flavor of MDP. To bring the naming in line
> with the rest of the kernel, remove the v2 suffix from the remaining
> config.
> 
> [...]

Applied to msm-next, thanks!

[1/1] drm/msm/mdp5: Remove MSM8974v1
      https://gitlab.freedesktop.org/lumag/msm/-/commit/a6f081ec4ce6

Best regards,
-- 
With best wishes
Dmitry


