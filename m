Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51A510706E8
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:33:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3757210E793;
	Wed, 18 Mar 2026 10:33:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wo+ZxrQo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AzVQJc1r";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E62C10E770
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 10:33:50 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62I8miBB084587
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 10:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=jTjgKhjwSus3+BKmKZjdNd7q
 Hwr7M6jiBm+FHwhdlrM=; b=Wo+ZxrQoRLfmgVM/YUIpe4YItA9s6T1TXNqGQQ66
 clFUWiI5c3IzQ9KveoHB7KlzAqK/x2458g1qjzgcNTRZqn9cWRA73aX3jeEbh3C8
 BBZoaSN8AC//eGgHKGUZK0B3L1DS9rcaHSOlZD290PZay0/QcRtkdIQJ7sCFI742
 dCfKdz/Orx5QvHbcPi0jqDbJbSjButghbdIrrYsn6TEHlbrcrhAANPlAISMX62mg
 ohBIkYFu1ZoJKAKB5DM7UXmEv8NvJbTb2/rakDlLFUVAkX7rhp9vxSrlqw/5N/BN
 NckPJLiBS0aZZ1CovJNlVIxwuvCA5hDgKj4Fv2kM7vpVGQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cykqestxt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 10:33:49 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5093a985e21so526707521cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 03:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773830029; x=1774434829;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jTjgKhjwSus3+BKmKZjdNd7qHwr7M6jiBm+FHwhdlrM=;
 b=AzVQJc1rYPgX3gIMezv55ds6igrPTv9i4XpkuuiYxGTC7acVX6WMgbl2s9HM+BpXAd
 6mrrMRQgZnHhTo7waE83L2RQsBDdyIcrIiVXGY4B+fAgMx7FxEUKjSTZJEHZ861FiuR6
 mtZOAsjyjmwpI651pt00qeZ6iCJHC9/0HgY3dx2Lnf0j2P3Uk0TIkZvgBg92y85TIIk3
 X06arsnJ3S0+V/hOGRnnXACS+UnHImJ3QSMsH4vKhZ1uG0YSnoUOsHISPy6oADVTv/7z
 VfuYTCGxfPL05RDGf5o6ZS7fCBcDFHwJU63hfqH0NCTtfplHCTijynmRXu3q/QqpldFd
 ToLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773830029; x=1774434829;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jTjgKhjwSus3+BKmKZjdNd7qHwr7M6jiBm+FHwhdlrM=;
 b=JQlIpKsmuxls5DbgnNpchyw8EkgaUDWtpEaTjlEICmsorwtkZ17bNBxAEPEUDQbeZf
 7RxLrxE3cb8EfX9cNvxKTp41TmNbulC6OySwFUJKzx3C9zh4CfNv5ddOCdrffek9zHfr
 jrR6ZsnBwuZEIJK7lLqTBS13qK/yr5Sc+rtshmmwSalT2nqCw6DpBb2IPdfGsYjaOmlI
 1aMXTDObBdbaq6tTwM+iEmItNobrjjBv5tWQGSvwA5BgUwz3ku3ioPaTC1//Hwo93n8u
 PJvNHGULUaJR+gPCo5e6VzO2Rio2fyQskTn2ZZukeFj8Xw+530Xss4LJMmCRMLVAkc6D
 efsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0zIsVYMOdPXTHBZNlSh2ufq1rKbnAGfsy5lqFYgtnm2jU5Wwe3K2raEjOlXnM27m7mFcdJ0Miz5k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwCEyZ/3WKPMEDtPtwhGpJE9EWt2iHK41YMjFM0kU1bjwFTGgn+
 GZwcmm3JDRf5k4MW4BcmzsflxhlBRUTAS5gPQs42rmyEWAQ6kMXZxaTkH8SWSYBWh2FvZlfSwnk
 2KBS9mIzMZjbocNI+Mjwg7O3sJRTagjpQ/0RC332UQB4mI4bXcJ1rlYjL3StSgYG4cekW3X4=
X-Gm-Gg: ATEYQzykSZDey99Y4H8uEBJgzygl4NYeTRQAuDKz9PGGuYa/X16L+uYjZwuCngMuCXH
 f0XWgnNtEa7NOUiJK7N7ieBzvKNO2rtyhIBos/eAjrjWQn0FERNasumXcullSidHtS6aGQ0HW0K
 RYnouD3SIhrpdn4WBAZDGepvNJbM62f/fsrBl7Fbnf8b5KlEkEhJnI327ieptc23qLydXBgslkG
 /t6lFYjirXMhumR2KJJmbmzx/AQyZoCvFJ/AhmuSp9tgrGeuhbnhOcFcdPKaNxyXHca3Q4CVEMt
 QzRYkAgO2jl3kmxYmy81MnMEZUrp+M5jOyqn/uirxpuooNvC/gYyJt7FM7PxVEhx1JpjiTWV+V9
 IzvZI7QKFgxJ6IZ94BivEhcf9dV8A8jaRELLOGk/lmBJkE0Y1sutXflPWtj0c7tXoAvYcL9msBW
 Hgxca1Wv8GA9RyciKQs0PrL1xmhnq3d1WftC0=
X-Received: by 2002:a05:622a:146:b0:509:2222:4202 with SMTP id
 d75a77b69052e-50b149046demr30799311cf.71.1773830028951; 
 Wed, 18 Mar 2026 03:33:48 -0700 (PDT)
X-Received: by 2002:a05:622a:146:b0:509:2222:4202 with SMTP id
 d75a77b69052e-50b149046demr30799101cf.71.1773830028499; 
 Wed, 18 Mar 2026 03:33:48 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38bd5157429sm5139301fa.2.2026.03.18.03.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 03:33:47 -0700 (PDT)
Date: Wed, 18 Mar 2026 12:33:45 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2 1/2] drm/mipi-dsi: add flag for sending all DSC slices
 in one packet
Message-ID: <rrgnyzpxo6g3ufjcnxnshexjotyq3riruc6wqjhirmcjo4qdta@gmwhs3mu2xld>
References: <20260318-dsi-dsc-slice-per-pkt-v2-0-0a1b316f8250@pm.me>
 <20260318-dsi-dsc-slice-per-pkt-v2-1-0a1b316f8250@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-dsi-dsc-slice-per-pkt-v2-1-0a1b316f8250@pm.me>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA4OSBTYWx0ZWRfX4tK95mSxJ6Kw
 co43EXVAQyK0bgtQbHVywzVrROmZbsDF+zgGvK3pls6RhHtadQmXSGRyq1KsCRB02KAVxlhGAut
 aQmywbCsD3qqd4aRS4eio8pT/ww6cQpwxfXrCt0sR0qHrfxI1B82/6+6OY19gR1ad1o4CWv3ICm
 cuXgRgidsp3xskeF30A+vbsOPb0OH/3CNK/k0ppkMmgLX3UhoL2CAZ+J4zz11XraosCA5rPommE
 WK2ZhkjezZEDpElfZGgOelyLLaxf9dlEFuYbZ0vqn5vaqvoHyL6O7JS1N4WzZeFXnGqjh6Zz07b
 /UpAZ16XCbAL/kNI7tQV0iRTfX7q0xCSVANcg8+qfDpJoqj+jw9W6uG3RTfXy3Dj0KCB18+U/qg
 KTlYzwGbbCojEZPw/SyiUxIQapkAtVmDEzilMRCt/DpJbjmvHjgoZ3fzaZ9GZxShYNmpcZ2jPs4
 c9nm42Lp/8D28xmKdww==
X-Authority-Analysis: v=2.4 cv=Cd4FJbrl c=1 sm=1 tr=0 ts=69ba7f8d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=T2ZltfVFVEVyCiQaPD4A:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 71vWRx6GTrywWDLLgRE7-JFOqiG6NYQS
X-Proofpoint-GUID: 71vWRx6GTrywWDLLgRE7-JFOqiG6NYQS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180089
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

On Wed, Mar 18, 2026 at 09:54:04AM +0000, Alexander Koskovich wrote:
> The MIPI DSI v1.3 spec defines two modes for transporting compressed
> pixel data: one slice per packet or multiple slice widths in a single
> packet (Section 8.8.24 Figure 40).
> 
> Add a MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT flag that panel drivers can
> set to indicate that all DSC slices for a line should be packed into a
> single packet. When unset should default to 1 slice per packet.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

As I wrote for v1, I'd prefer to get more opinions before applying

> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  include/drm/drm_mipi_dsi.h | 2 ++
>  1 file changed, 2 insertions(+)
> 

-- 
With best wishes
Dmitry
