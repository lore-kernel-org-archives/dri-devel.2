Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD18606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 10:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eoOfQDU3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jFW53me6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A9CC10E3B1;
	Thu, 22 Oct 2026 10:14:11 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69D1710E386
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 10:14:00 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M9xqqe3478839
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 10:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=7yWfrvru/Q1OyZVwkw14d4Bt
 xF9a07L9+eZitoLa27c=; b=eoOfQDU3bRY7mAVH3hmtcXkjrdH6IACjn+phqOdC
 tA2VafhU5tiJl4E1ugTgm8zVX/Lb/EUdy3ReAizStqNLvcpQC/FFTbZv166DoaDF
 VhIzJv3gDis0/ejzom7d0KDBQIRlYdbiA/ybY/fuKsZGNdI6KCcZI28eNyK70TDh
 wRqAnTRARMOtffz53zEmZVtNjIwR1jvPwpdmfADsIf0MnqGO0ojnRbe47YtE0eow
 XS9tQ8dtDz1M1nRIPmzt3TkRaveAOEHZBu6ng9TijkLuOh5HIOvUlQySei/HRUiP
 lS8vRuZqdzQbHPhbLNCOAzhOyom5uSivP3+lNl73roGr9g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93a1w2e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 10:13:59 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93ecdc701a2so220917785a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 03:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792664039; x=1793268839;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7yWfrvru/Q1OyZVwkw14d4BtxF9a07L9+eZitoLa27c=;
 b=jFW53me6u/uzH59WFcSCTzmYehMJgxaBi2+huydKQ4hx0pff0WPBNrjYiwJSg5tEf5
 FcHOFb/5DrQ8jKxZOQQIbdgic0j97VwhzSC1PpkfQFjuX7pUJ21JIOv+h7LpMBHWp2Jd
 RXE/DnBU2c6mHxE6nOPn/JNtv4IHla2vf9SkSemqKEOuuHc67Tup8mJ9wsOuhy9BT0z6
 Q6SWeu3k/wxm62c9GCRjHVVUktq31UB+TUdL0NXbRd2kQjvTGK1SgycU3uXad/zXwP5r
 gGfN25j6iDlSHxZqhzDGjkssDa8qUoEe+21cuO/6S83Mu/inCS6bXwEq0Rt2xekvE/Xo
 1G0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792664039; x=1793268839;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7yWfrvru/Q1OyZVwkw14d4BtxF9a07L9+eZitoLa27c=;
 b=NWuWth6SQ1LQ5uVeagJHh4S28ABBqkz2mKOeJGHuKHqfSfjwtP1+E4SRArmVWEt9mV
 fshN7YTozQnrkj3+XaDciU+BfbamNxcF6yVqDY8lzPG89yuMD+b+9gHUY2SahoBHWUp1
 AuhTzPe5PBOsHxLLz6RrEZ0043UiR4V2cxqwOJ/f/moeVCtsA2XLBd8HTBG6P304aYLM
 ui037HNuwF/OjahO153+hNNcgb7wBmCNn8qBR3lBzBgKFLmjh6QTmracmAD8iV1qZs3v
 UMOAPQsYF2inFvU3ely2Gen5a52qLCl8/F4Mx6+9pxT6E7haXosR2qlYhAyLORePpR5e
 iLhg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzeJdr1cjlm6mePGD9Up34Rx5Frk52O2AzDU/RLlaLY4d7imQ7JSlFcnu0SR4HnvriK03FsWYUoLoo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKUt0fyWDjkrx9ht5BxXkQ1FJoDkPTc+nAZ3TMhjF7p8FfkdxHW
 DlNZ/Hr+puzcF2SUh38e0XgVT/4g6nBoT/KSLGEm3b8uDuieUui/33o+6ksn+aRzQThv61+B1yr
 mZzelHdRgIPH9fJSlm54dozgO4PSy6NqzHZaPiFahu3A/cFJnJziPfeTcukBCouV4tRdvKEg=
X-Gm-Gg: AYBFou06xrGZph2d0J9tBNZdi5AIkghbDX7vXddEDMjr8CUrXBKThPkfl9abd55ridA
 p/NtZZ1AWXwsmtbTU0AmU0PZNqh1+LUp1s3xrTGXN3jw7S7zhBdIjg4V8Ukw0um5AoMcn/vAQDD
 CIIUd8rGuqtKtncJtMDcO9MrWOpAGgTDm2mOVYSkrM70xdcGke81oVBnvkwrnkiWYDMjQuy8GhA
 4+RqHnIPM2Z4YJb/Vjq6Z0KRZ3aDNKV+C0RrVlpk7xm9pPrmhzoqGAkVcA65PlxqZalO0neqOSO
 5/xydIJZBlv5MoBItl79UdJfVPT7qbwsQU2Gm8t3LVqWU+fkk5KmYPsT7pyMspYnzFl7XFznaMx
 V3Vy2kmD1wUvNSi1K8JWpqsMvmBcjbbfZU7SM8UiecVpIi0V/ga0r7YyWExkCYouh+m/mWfcD6y
 i2n36g7Se9Tis5
X-Received: by 2002:a05:620a:45a1:b0:93f:32c5:69b0 with SMTP id
 af79cd13be357-93f57fa3df6mr758338285a.60.1792664038767; 
 Thu, 22 Oct 2026 03:13:58 -0700 (PDT)
X-Received: by 2002:a05:620a:45a1:b0:93f:32c5:69b0 with SMTP id
 af79cd13be357-93f57fa3df6mr758333385a.60.1792664038225; 
 Thu, 22 Oct 2026 03:13:58 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfae6337dcsm16234e87.72.2026.10.22.03.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 03:13:57 -0700 (PDT)
Date: Thu, 22 Oct 2026 13:13:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: kaanapali-mtp: Enable
 DisplayPort over USB
Message-ID: <ygtcipnjt7dxtkohaolkshopuvxigfx5gxpedjqdudazuk6qhi@t363kbfe3c2j>
References: <20261022-kaanapali_dp-v3-0-b5ae8e6083c3@oss.qualcomm.com>
 <20261022-kaanapali_dp-v3-5-b5ae8e6083c3@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022-kaanapali_dp-v3-5-b5ae8e6083c3@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0MCBTYWx0ZWRfX7DwUzTYPwR3R
 luISwDaBNJQbubK8P/5WNEWN4dHEOKqTdg7nOYYxNEeF057txIlRcVTIwmTEdIdLdIQlwVNTdus
 JIawEu+4gHl+uXrHiaCJzmXRT2j2nm5pKp53L5C1k1g3rjgmAFn2gQRmxh9JuvgHBhXUOpKefHr
 ciTsafyy6tGtGVFVJYpf3faUHqnlf6QWNguHomjxioW0L8GrpW0b1sseQR/yhi4YYH+EWhUEQro
 URo3MHBe4DVdgYyYQtNw2lSy8xgjv1hy3ahwV2CWW0tAom7tCc0tUirTYgpg3MkSrXVLts7tghK
 YsvdLunjua/Xcu/PWekQSGpSXEiYijwpHhriOw85jgGMdnuebdnf11QZmdwsQ9on5fGbSe16ROr
 byIeb3GAlkLyaYM7xGNx3A6YgO/d1HFWbJBDwnli/cNuYmEHrgwrdDE+hxsvrBGfOWK1nXASVht
 nVCZaQBxK8MgxhfkeQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0MCBTYWx0ZWRfX1Yt2bTVQRYu/
 Pfe7DdoImtbLdbdeSxqTp8w4Xq+Yg14hnN1jh6xKkaM97FFRYZ6JpA9nqFwdHuVKT8eXSmkfXMz
 67ualh2wgsGCw1pEsAXVs5kVm6GWouk=
X-Proofpoint-GUID: 5bZSTvdUbDr1pgfH3-miRpa68mdrlQS-
X-Authority-Analysis: v=2.4 cv=NaFzRGD4 c=1 sm=1 tr=0 ts=6ad9e1e7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=tbCzt_ceUV_s8fUbo54A:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 5bZSTvdUbDr1pgfH3-miRpa68mdrlQS-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220040
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 03:19:46PM +0530, Balaji Kalkonda wrote:
> Hook up DisplayPort parts over Type-C USB on MTP.
> 
> Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
