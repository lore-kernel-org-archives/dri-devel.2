Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2520ACD4F3C
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 21:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6557410E0C7;
	Sun, 17 May 2026 21:24:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TF3vj+r9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c7jixXbB";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8F8E10E0C7
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 21:24:56 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64HGmvKp2667887
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 21:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=vJ+pq0wVqiTr5Da621Qq+GFD
 AAi6LNEw4Xd4lZj0BSc=; b=TF3vj+r9gC5N8T6347EzSoEqkRCosy8HHvJldvcS
 nhc7iUIJ0dEagFVKwPj4YGk0B0ZngqT4/B3fV/zBmWtoi99YMhfGVeN2PVsQk+QT
 qqBiaCdbErb6aPR4x2BTmX1jRBXkD7E67tsQr2xUXWrPxoRl3KNKOMdyT/fRKBA/
 Tk7bHTcSp27aFxrlmntHeNEQvoZiHcJaWhNzbVUJozT/aHg37+7qVnNmZeOqzuoP
 gESKDqFbShp6YhABdHH9IuiUghnI/TMjgtGrP9oN6fJxgEMPq7ZmbZaIGGsc1wx9
 OyTYZ3+NbnCYAtcGgBUsOB7YK0YBSAxWmFKdATNpgY4V1Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6gwmbmnh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 21:24:56 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-514a182b90dso20758781cf.1
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 14:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779053095; x=1779657895;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vJ+pq0wVqiTr5Da621Qq+GFDAAi6LNEw4Xd4lZj0BSc=;
 b=c7jixXbBLoLu8dnfNVCRuuSsyJQTWuPcOfZ38IUwcHKN0Hgk4koIlY2xyk0dznlkKJ
 UOr1ll6ToM3qEqb0sjpT0u2Zdp6HdAyfLe/QVHmaVvseF9xeNWj+pmIr7blKCrjr7iR/
 iLC7Ih5Hw+RmglNrKCFcPXCosvBDW8Y13TgVqIFXugNmEW8G74ro45jFH3LNsW7QshTc
 O1pWMrGjogK+ioALMNDLa1JxfmliXXnonBitY95tjNorhCrBs9nY2oI1wb+bI/pbTZVr
 lMZb9YmYhNv2D0Y5i6C93uvihPhaaXPAyKPam/mHY3ev0zIK+g457OD56UymQ5PYIc3u
 2p6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779053095; x=1779657895;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vJ+pq0wVqiTr5Da621Qq+GFDAAi6LNEw4Xd4lZj0BSc=;
 b=IHvRjXEBTiJhhWNKUJSLmlsWCqMnsbcqNRRfWvIejt3xKQoiVLM+IoojiJwvu6UmE6
 QiGELDF7PtJ9WtS8+AoyYP3m+T7Hz3MLHh6JRRWEsmqABNGk3ufa4uPGf2nKR2bwN/jb
 FRW9kAal+DuAExVSdsME1Abf5xxZsq1eYNY3MhZMBqWOVXP++V5crJ5vfT6v4yX9fHoU
 bH8SIwjKMNKT41AZ19gbNH2J7rYEEv3dX2BSfSkTkrF1yzjJcSabkEgQ0LroURdLxi//
 UCvZKCGgf/OsMYpErF3QS98P6hNGm1jtU1QA723b1z+/i3PTAIpY1gSxDwPeFKivWZIi
 S7RQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8MREygg48LI0kAcmjdtXxCHpDNyrO1OGOjvPrdH9Bs39pdKnzHtC9WJDnVtxKz25J2JO8+QggXBvg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YycxKYNMNZk5OzOqExwc9id/d5wOnXHDoT9WYnwI/Uad7hdlByh
 YIsEuQ0otElNMisgrh+7TP0/rTnZOplseMtXpmEQUdnGL3cWOrCnkmudEymbHEZRk3FWA+JwGjB
 Cq/7JIvUihuNFMP+OKK8culDGB5RZFpLYiu1zu8GS1AAeLaQQBEUT3PFkBhooML1i7W4MPnQ=
X-Gm-Gg: Acq92OHLUx0s9uWaX/7wK9kJIDwUluFU6drCcSs4tfkya1fewE5NPusbH739IgbE90a
 UK4AWEzWd9FXVudKjUwBmfF14OcymYU7KfywJ9xXuNvxcJ5bvFooTKAXlNYT+kCXI1LGF0AS5uL
 QKJCcUbvDzfDAFTX5hMI/0UtFHxvweVOLY3Wm5X3UnLmCpc6ftTRZd1IpGraic09a/lHB7vVWb3
 FIg7t/Yb0ceukGE2oZiI2F0zbghrvaZ5ODpPeRclk9lzZc7V5brF27MfsSWYeNJWnF+Ogo0Hoh9
 aK8RbvG3yH0QgtqUXg5K5aHVZcYIemQFvOHHhw1uQ1KOInM5Mt45HNaPf/A4wyiKkiTzXQDPdpl
 /AVv73ty+4kBTSRxUzMiSzbB8h9NR0cuJLBHPQcvSUK9NE5a4LnvHyiRoDp40VuTHH+lBMwDyKc
 W0wB4HX82ftJIumLyjN78wZIXmhSLjNtAD6Ng=
X-Received: by 2002:a05:622a:250e:b0:50b:4491:a2cf with SMTP id
 d75a77b69052e-5165a078cf2mr177666741cf.27.1779053095427; 
 Sun, 17 May 2026 14:24:55 -0700 (PDT)
X-Received: by 2002:a05:622a:250e:b0:50b:4491:a2cf with SMTP id
 d75a77b69052e-5165a078cf2mr177666511cf.27.1779053094986; 
 Sun, 17 May 2026 14:24:54 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10ca52sm2871074e87.15.2026.05.17.14.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 14:24:53 -0700 (PDT)
Date: Mon, 18 May 2026 00:24:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Yuhao Jiang <danisjiang@gmail.com>
Subject: Re: [PATCH] misc: fastrpc: fix DMA address corruption due to
 find_vma misuse
Message-ID: <hkqh3vriu6tqkxi53t6mvjn3hare3qbrkdvwenk2rfmtwoq2ft@nctcnnu47mwh>
References: <SYBPR01MB78819393A1F4FA658B2AB076AF042@SYBPR01MB7881.ausprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBPR01MB78819393A1F4FA658B2AB076AF042@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-Proofpoint-ORIG-GUID: kr-ksIb6sI_xjbjqvvgY8ZgjT1uraxx0
X-Proofpoint-GUID: kr-ksIb6sI_xjbjqvvgY8ZgjT1uraxx0
X-Authority-Analysis: v=2.4 cv=W/AIkxWk c=1 sm=1 tr=0 ts=6a0a3228 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8 a=pi3H7CPb95a1Pu1mXnEA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDIzMSBTYWx0ZWRfX7DU8y0D5UJpo
 QjAggGQgdhV9bumCdcjMOtPLXEXIcILfF8Yb0yvXhEXesC8sN9IExpk/OSrW68Yc6khAbQQ2Y5K
 EcsUFyxW5HTC9opPphiMiAQOIzoGjpsV7xHi69VtgQ2hpc2I6YLdZXmQFCRPBbhl7CYgsbHrOUe
 vah+bYkiaocCWZQ5wcxDA9uhMRy8mFGqD07mno/IezKERAKw6CO06oPcPhhQNLU5is4tWbd7nsy
 E4ZfEu4jDQen5mBsWQqu0gK+cb3FFKjU1A3M7d86YvQKWLao0ie64WZ/LsIl79H8ZFBdpavI+78
 IBD1pTPa0XioXviTcFC/A7BfNTnp/tIWS9xBl02HqEAPL+M4pudG04iBhL9zJubcQknkATRV1DR
 z6NuNwDXS4NMBHSGHneW9Zzx+mOr9F4qRbz+2yR9RpjgoXHdAr0IwUMlB+gjZruPdDf/zz5KOGY
 tTKWeSYRjsDzn8Sffxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_05,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605170231
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

On Fri, May 15, 2026 at 05:16:03PM +0800, Junrui Luo wrote:
> fastrpc_get_args() uses find_vma() to look up the VMA for a user-provided
> pointer and compute a DMA address offset. When the address falls in a gap
> before the returned VMA, (ptr & PAGE_MASK) - vma->vm_start underflows,
> corrupting the DMA address sent to the DSP.
> 
> Replace find_vma() with vma_lookup(), which returns NULL when the address
> is not contained within any VMA.
> 
> Cc: stable@vger.kernel.org
> Fixes: 80f3afd72bd4 ("misc: fastrpc: consider address offset before sending to DSP")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  drivers/misc/fastrpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
