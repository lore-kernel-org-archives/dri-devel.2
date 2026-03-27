Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEF710F286C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 19:47:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CE2110EEA0;
	Fri, 27 Mar 2026 19:47:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WCf6yaB0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bDGAlOOO";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78CC210EE9A
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:47:48 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RI2NOV890132
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aNolaSIJQnYnfyjuvjrLxsZjP4V2sU/C+yvXWyQhc54=; b=WCf6yaB0S8uXUNno
 CiUmkAawZhgsLfvpWRg2+qdg2vVK63fkaMOkaHWh5KlB4Se1i0D65SJzQJIiMeJ4
 BWM0lXoOggUa7Cr+6ZQPcx3rbaQM/4hHikcS6TyKoCjIkbDa8Idhh1Zywv6gW22C
 cHy/yZAsJHSrxTSoBNiyPSXSksWmUdTMRqUXgRqEO5tHQt2xQBYHMgFElkjEdgL1
 QlFFXmKsDyNi66lBpxPYGPrLsFKmyhz2gUHRcEjChCnz9Gw4vtxx3QNMo+19W66D
 9nDkrtADe7rht6K4mc+EH8mgMWwV7Ay1Y9sU1A6nEhmtI4SmXGtdw7Qm8kobDpay
 y+um3A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5vf6ruec-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:47:47 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b4b81c632so75837321cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 12:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774640867; x=1775245667;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aNolaSIJQnYnfyjuvjrLxsZjP4V2sU/C+yvXWyQhc54=;
 b=bDGAlOOOZdnxmbaz7yXAy+FdWK1a414ZJLmOK/gVaBbMxD+T/4HGYMCud2tD0i8Exr
 QZFrv6uuTgfVB/IFEJ5ZJZH9Hj6n8oi4cBsJ0a61TG1c3tp9JV1n71XhQYqHMKbxzZ7V
 pxvbF/tIjFM7sdj/sYY5u+YeGe4Otz44KU0MBE+YKWt32OOf8UCyUrpPSAHv5W3Ol6jz
 jLOOuoYfyfcGsUTyWHQAkae3IvUbSQjryaqDeguBM3tENHJZ5YkBE5P5SjTSVE5sjyYM
 tET+eiUqQcm+N2TQGCjCuru45KRppCEFqgrs0FXcIWhs5FRhN6ZrslZQkpxyhEpVOLLN
 fXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774640867; x=1775245667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aNolaSIJQnYnfyjuvjrLxsZjP4V2sU/C+yvXWyQhc54=;
 b=CGvjwYqVN3e1QqOmwG7qtcjTJHEvqDm63owAr8wv1RT5ZndYVXda5PEb1KXEAyptkf
 +ku78nPv7HmNkbl27NKBHnf6MsqnPcOMpsf2GqrKtd1rL3wbECHczU8B4r7PKsWGBBIj
 +5rlgmC0SumsVTSvdD5urTsyvmWHmX27r4GOuqRiVow41udRwXOCOrqdM3zoij1cRw8Y
 jWy+7c8NrYxRpxvA7BWneURdy2c/uZzknZ5fDA4V8ONRmoN7T1jWSI5Ir8jyP9fxiyte
 SblCYz0sfmojkIjbb/8pUEPo6DA2aZwqD0odupKtZV2HrwrahD1Ml67ilDo4CTvkACYw
 hytQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkNxcy9iUFYI8OtuKng1ne6g0mzqLb4uDNZFXaTMjShAvIBenlcHDQu0R6mr0YHzybmu13fcOiIk8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx2BqX+cTXFR1uGG3PyHZvxDppImJuJp27dJFhN8DIV/wbD7aEV
 an6kXI3PS8Uk1syoRcxOijsdz4xc1Yig3aMVOF+bruGntPnPekn6Q4U4L8BN5RCF2KGUYSYv16p
 GXwSHGFcYZEvgXqGPrex29ruii4KQ3kqkuFKlc2dLVlVayNGTEUdsaIVcAS/FgdP2Emfstpw=
X-Gm-Gg: ATEYQzyF3wZ/MML4Gx3lZLxunA3GUVBEt8UULB5tHpRnd+RKU4aN8U1Jq+Zx7myL0Rw
 sFRFKylv4EAeqAwvrGbubca/KZez4BOph/S23KJ4iW7eld951vGotZ4PSjPLzcuctBvQgDPsA2x
 B5yTnMjrW5Gr3wjgiu8+ed06TOnHBfllSUVFGwfJrY1xGiFLrlMYSAQCPdnzG1f4wOLIlqsGVqb
 gJf+Y+eYowFOMB/mbVcse6FLRiXzEtQNhSLbhoGrG3o6m0EK98+VD/yUugezwnKh3llufpP4t/1
 7Sk/TJDCi71Y3Bli4w29bl/frjIfgsVnN4DLI7BpDyeREwUGP4Noo8B3rJYvtSC0P7999v8eNkA
 7neJCNoLmw8iMeu7YHGVE4/sKTVQUrkry089Ze4wsf4cIyxFx1QwShqXDGXf4v4UMkBhvFCi9eh
 DRMyVXymmfOVxSOmxlSL5oTfqul4LPYTiY
X-Received: by 2002:a05:622a:120a:b0:509:1326:ff24 with SMTP id
 d75a77b69052e-50ba384b0f1mr48714741cf.17.1774640867050; 
 Fri, 27 Mar 2026 12:47:47 -0700 (PDT)
X-Received: by 2002:a05:622a:120a:b0:509:1326:ff24 with SMTP id
 d75a77b69052e-50ba384b0f1mr48714321cf.17.1774640866478; 
 Fri, 27 Mar 2026 12:47:46 -0700 (PDT)
Received: from umbar..
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c837130basm275211fa.12.2026.03.27.12.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 12:47:44 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, simona@ffwll.ch, airlied@gmail.com,
 Ben Dooks <ben.dooks@codethink.co.uk>
Cc: marijn.suijten@somainline.org, sean@poorly.run, jesszhan0024@gmail.com,
 abhinav.kumar@linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/hdmi: make 'msm_hdmi_pm_ops' static
Date: Fri, 27 Mar 2026 21:47:38 +0200
Message-ID: <177463970805.3488980.13091032797245779789.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310132501.195954-1-ben.dooks@codethink.co.uk>
References: <20260310132501.195954-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X/Zf6WTe c=1 sm=1 tr=0 ts=69c6dee3 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=e5mUnYsNAAAA:8
 a=NChewM1GXYrQM836dJ4A:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: win_Dhq-blf7QcF737lfEKY_L5e1zELx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEzOCBTYWx0ZWRfX8xGuJfSem05g
 f6KaclKye0rT8o6q0kO664ln+HIpfn071B8QDlusKuwBPp+6Mw8Xl/JlEXAx6Ek2iCHTxOEkOiV
 FWxoQbsM/OsBnPKe+5A5lPO5btoiEKGE8C/hWndT8yXsjbsl7joZfquFjBXwlsqxfMzilfVhHkS
 EOxZARLLClDqfbPyHfm4kp4Wz4ATzhV8Lb7WOeLTtqx1fhbu7RU8O+LG5kuJ/8sxGn3tZ+LD7MV
 sBX3IkuOUeTZQ0ALmLxsR+IV594Fa1rSG/JFX660txxf3Jhw/uaIQtPGXwiuOrf5I+2nCT9rI2Y
 U4RdqXDATUX0N8Gx/JV23hnEfNp0+S99E/RouBjR824jG11wxhmPMj9jECRloJijj8EOcaqD8UP
 dETjBBuXuwqBNoQ8xrhoNN5Pqv2mnxthjiy+GoWCGYzo31VTvudCyPJVZGX1axy764XFU53wddk
 dJrlwlv4WY27EFtgngA==
X-Proofpoint-GUID: win_Dhq-blf7QcF737lfEKY_L5e1zELx
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

On Tue, 10 Mar 2026 13:25:01 +0000, Ben Dooks wrote:
> The struct 'msm_hdmi_pm_ops' is not used outside of the
> file it is defined in, so make it static.
> 
> Fixes the following sparse warning:
> drivers/gpu/drm/msm/hdmi/hdmi.c:432:1: warning: symbol 'msm_hdmi_pm_ops' was not declared. Should it be static?
> 
> 
> [...]

Applied to msm-next, thanks!

[1/1] drm/msm/hdmi: make 'msm_hdmi_pm_ops' static
      https://gitlab.freedesktop.org/lumag/msm/-/commit/fdbc6391b4d8

Best regards,
-- 
With best wishes
Dmitry


