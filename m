Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03247606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E0On3RRD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f1Kjnq/P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47D5E10E176;
	Mon, 23 Nov 2026 18:13:24 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1AD210E176
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 18:13:12 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGHwsJ236075
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 18:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=W1rYKUQurdfUpTs0/e4xfd9Tck45cp/Lz+Egqb3NjbE=; b=E0
 On3RRD8QKH+iGkuS4AgzN5qY2LFi1otifOJS7h/Hk1yBWlBIXCRxRCIwgZ4K4AU7
 YffkwXQauP7q/FQC+Jn2Jws3vSWSyEPR+idymqsoAuQp4EBLXF9r6rOWCqS/YzGZ
 LUnVkzGyeSW/LPn3RrLnicUR3KTHeLtpcaktSWLKr6J1/yBSWJVxv1qVjRr5FMbk
 Nxz7MIsFE8wRQPljU/1ArbiW5ZyWx7aXVpasruSTVo4jX4q2fNwNLKhTZsV2n/Ch
 NuXmmpHjLL9kZ9yCM7A4GwPYtfy5jRjYPGPEUataE/mhyDTSl+qqp6Ot9pIGfBYJ
 o6rKiUME3xccIp5UbV5w==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4evsjxv3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 18:13:11 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-703a37d970eso3673681eaf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 10:13:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795457591; cv=none;
 d=google.com; s=arc-20260327;
 b=r1wC1NjCkvYbqlSQiBJPE7peHrE+kKjTeZapW4ikIl/iEcku7jnUTo42o3k3EKlysU
 EeCJsCH3Ex47ivYUobw6RNwM+QLsC7yfEUEhbCdPqveBwiHE7CVeszNuvTUz4U11f3bP
 k5SYznmLT4YX2MiyeCG+wdclryRWtqfvqCosTJr9r/O3QfCsEUefZkGAzD5UlFQB6yFk
 PddjjaF1q+SZUcLSxU2MHzCYzjJguYmR3ZmJseiWnQ3O1zFkHEbIayt+iuwAO163KZeg
 j448SZ6WLn2mCihLb2wNvS/hyMvCLQw59PeCVPxofBnOR9SQEM3gitiSYcx6/9rGXF+c
 +how==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=W1rYKUQurdfUpTs0/e4xfd9Tck45cp/Lz+Egqb3NjbE=;
 fh=wJKxmQi/sw7NBdG0AScSbUj3FbowBVXhV0CxI+FobPo=;
 b=a4bMncX04G3Hqc6CBXpBVMv8E/4QRKOcXH2+mku4/XmkmgNZWjJVWDe4YU3T2Og6y1
 SqiQq9kpmKqmGe8vAfNAedGrJ8lBwku1ObrDdyln79BIbHL9x1KzPgyVhmQ/Re98/4wl
 NiHMfIQhVNnlXNFA3En9Xsm/gLlgti3gD+AEBD+mK7b+N5JG2uzTp2obvftNAtjRFMuH
 rIqiA4oq9/TpGNsoAooLt35vwNqd6ZdiLC3YCnPRcDlEUPHX9PUN8ToKiV6I8s004I2F
 PKrQg9H0/F/vodoqqROuAMXboXYen3ffDr33aQOX+9rqShFOdb62SDa3gs6JY24zp2vb
 5MEQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795457591; x=1796062391;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=W1rYKUQurdfUpTs0/e4xfd9Tck45cp/Lz+Egqb3NjbE=;
 b=f1Kjnq/PXzsMXBL5Los+V8arLyTAybzn9yDePvnzCkVGhrKnPgOVRjROVFutjHF2l1
 s2GSgVdE5nEAyYaQY3n+RfroH7dAkPNNF+l9cllKBxwY6VuCcU5gJ2+DNvw7yMQ6I4Gh
 c6JXU2y51YBozREMQeWz7Dx0L17XpnjRw54G4e+Bn/yfcXxn+4oOHNTXSgqeAvF6jVF1
 CwVnELeK/KBT6L608Z/HKbAQSVKLzqX/7BAaA0QxEV2HYY7rXUPX2qq/d7fTNndHz94f
 CF2mHMvHu1zcC5wBlu+JXqiNDQUNtz3r//bnPJ7jYY3pUkAtQEZXcyeHwlhSBCZQLBNW
 rxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795457591; x=1796062391;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W1rYKUQurdfUpTs0/e4xfd9Tck45cp/Lz+Egqb3NjbE=;
 b=u4Wf5QxxaqRIHVUcEmmDWlhrYXFTpk+fstXYxWco9Ir5SXrJzxr50SXdXmVv76I8zn
 P4rVHQqFkM4lxGm/ErnwhSFTuneRcSpjxqQax73VvArS3fcBQZk4Q3HdgrgjvbTI0ApJ
 /ovxVg9nbCJ55bHDF78LaS9ycOmkNdiUc/SjX3IkrL9/EQGXRXfspqtu5o0/7KrWOGGe
 cHnWtYwuM7Nwq92mCpk5qeZtvV2zMTYhWZtunqha10Ja4h1qDMOzYR1IiPSjwJunNB/k
 Pgzy+7tFKjNAoNCn4ZdpZEGSD6QsZpE1uUeP70jNgT5nMZx/fyIR7o/FmIMlDOlFJAgw
 jNiw==
X-Gm-Message-State: APuU4Z8/XE5E/5BkNAPZJW6T3KkNZQ5HZ/EY+gt/RCQfO6cwYwBa1cC3
 0twf6FtAAQLhd5i+5EwwUAwf01KDB0qxJRdKUXU7qki3jUm4E5gPyods9S4IBi3cYDLow99lfd9
 ykFImINCcthiJ2Mv1hl9xhQGEQCIOetEUeEtWIT64L/Ekvh3vY8Xx68pwscIu4WeA6PpLP+aXPv
 uedT4F1z+ooGeZjMY8bOTqUzTL2mM2oUV4MaMZrL75uWb/JQ==
X-Gm-Gg: AZFdTZdy6rX5QJH5gsPfQzqbSJQK1JOoIn2tJuRd1zM4wGw6w2+ZBZeztlqyQ4LPpBS
 TrhmDQxUrHT+hZeloka11rSNfhsLZHkAlnYn2dEg/bv2jQVrZaqhoaqLFWtg8PBYc+I8DUz+omG
 427VDzeN3clvxDzJNVsODBTKGJ1qCL80RBH593IVjCbRSTgmtcG9phIhWevsNtDpgTleJLvSE77
 DlbmcirsGCMtlTQ/oR7vQ==
X-Received: by 2002:a05:6820:570c:10b0:71a:f390:ae4c with SMTP id
 006d021491bc7-71b396335cemr6592080eaf.82.1795457591077; 
 Mon, 23 Nov 2026 10:13:11 -0800 (PST)
X-Received: by 2002:a05:6820:570c:10b0:71a:f390:ae4c with SMTP id
 006d021491bc7-71b396335cemr6592049eaf.82.1795457590649; Mon, 23 Nov 2026
 10:13:10 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123172025.402295-1-robin.clark@oss.qualcomm.com>
 <40157685-826e-4011-93f2-1632b244a1df@oss.qualcomm.com>
In-Reply-To: <40157685-826e-4011-93f2-1632b244a1df@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 10:12:59 -0800
X-Gm-Features: Aa3M54pc3x4GvgAvloxZVUq-tvmXPPOywnjTSJ1ICbSrR3N_W2wUuR71qCW52GE
Message-ID: <CACSVV01GuU5N1TcSP9mK-Um-KrKeowuBQcc7PTOPHirX01_y_A@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/a8xx: Add missing preempt_record_size
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Connor Abbott <cwabbott0@gmail.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=AL9GXjHq c=1 sm=1 tr=0 ts=6b048237 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=z8o7zT-b7kWXHJIS-gcA:9 a=QEXdDO2ut3YA:10 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-ORIG-GUID: 90xDHkYaf_weeojuij3Ds1Ix10CS71zw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3MiBTYWx0ZWRfXxZPpd04w8t0y
 9qOffekXyQF1vg4EI9jFHfVY1Bbfepz784lv2dqYWs5LlbuG6RCPB5BTwxbLuJxF+T+GktYfDk3
 YuVa6ufvTMl9wejc1B+EY6HjHpx/nKzHzT1Fbz2Lua/Cpxue0+A/G0QmUofbVM7J4nlQoOndOWs
 LXYGfXZXZ8ik49ZMt4Fih2mT5/ItZPY4nB63LqVvu8ru824n9rxNY2UFy/ce1S0fGXa+zFpFpkD
 RnsIUZZY1vGuR0ta5Pm4DA1X2q66phbp3ZRplwgHq1mRLONvEZrvtuQCWl6u9QJBlB9IPmA+aJo
 cjgnnRQDi/JpxI+hMA4fzyr1hvM1Eryrvmb62lFZCJFTK8jF7kmi+F3uti+H2JHB0vztbOPN+Tr
 pukR5SFgguCJclyK/MpTGcHV9mlnI8Ad7WyvPOGVKs3E+pdM5fZTmtN/2jmE3LGWnqdGUpHKZVU
 M5dBuM5Y3skc2xYyPCg==
X-Proofpoint-GUID: 90xDHkYaf_weeojuij3Ds1Ix10CS71zw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3MiBTYWx0ZWRfX3ZDwAq6qihdS
 oDHC59+KBUtfD/KkGhT/izNKF4tIY9Kiples1wYZzPwkxX2o/p7favyj3O/v6cGy+r7Nd+iU94d
 xsQM2+EFz44aCptCAnRw+Mig2qnPAzY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230072
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: rob.clark@oss.qualcomm.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 9:23=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 11/23/26 6:20 PM, Rob Clark wrote:
> > Somehow this got overlooked, and Glymur/Mahua were falling back to the
> > default 4MB.  Which is way too small for the amount of GMEM on these
> > devices, causing faults in cases where preemption needs to same GMEM
>
> s/same/save?

oops, yes.. fixing in v2

> > contents.
> >
> > Reported-by: Connor Abbott <cwabbott0@gmail.com>
> > Fixes: 7fad33097e67 ("drm/msm/a6xx: Enable Preemption on X2-85")
> > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > ---
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> Konrad
