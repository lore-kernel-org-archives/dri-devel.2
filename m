Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D47CFF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 19:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 518DF10E38C;
	Tue, 28 Apr 2026 19:44:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Eexcb2dt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fYSGWZNm";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2C3910E38C
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 19:44:15 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SFsb8f2890746
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 19:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xN5+FvXyhjHZgxw/ab3OvPn3pd5vOjGOlb2vyCAzntI=; b=Eexcb2dtcnaAmQxg
 FOBp+Kc+8StcMY4Dr58+F9Oq1wRQteIE1IyYof1H3ITr9bWPjdgK4q7jzwqsRWqo
 v6w9nYIzg9shCshZYHpqQjrg9/D4XlXzFgttUiRyBtP+LUJptHzwJHHMPCBjmHvA
 KdICCGUMH/IuUoEesGv5yvPcRdnt6E0LZi+iyU0pnU37KyvMiXL1wNK7znCAVkRw
 gUdQQep3hbnIQbLY4RmGK++Fjfa0E8RKFR2z4C2I787LCQydIAMhctQCRmk4hFIJ
 XhCQ1WKqDyDE0VOKR53J7bwcv+OwPnk2FZkO8MQ8089q5sUS6rQhZ9E1MuBu9dgX
 d3k/cw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dttgytbjd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 19:44:15 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-56aa6d6bb5bso11019751e0c.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777405454; x=1778010254;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xN5+FvXyhjHZgxw/ab3OvPn3pd5vOjGOlb2vyCAzntI=;
 b=fYSGWZNmJ7vJVVTkmVIiw3BHn+8knqVF1srrNNQdroNKJdfHcFmUatTjyFSUsQ7/SS
 K00Gb8+uyxW76eLMcbjxDWNVwJmLVVuzpfibe0ttdWUgFv2x5qjwwYXS1AgdpRRUSu9R
 7DB+GEujLItJUmyHyHgxaEGIvjSavEPwb5D8r0tp+n8q8OxK9qxl3NrgO35/wai810t5
 b//XAETjBPrLnUN6Qm/YxpoW9dmcyMHtsNIAK7qJEGHtCYQuKJAlxoB4tlRF7VDJ00N+
 /Sm0vDS65KrF+Nr94rJ/9gur6pQO2cHBCpHEeID6knCI1rjVGVil12mcnlYUZ9EeJR9e
 Ys4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777405454; x=1778010254;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xN5+FvXyhjHZgxw/ab3OvPn3pd5vOjGOlb2vyCAzntI=;
 b=MeMZe5WXubpcJXmGctr8VMi3koGqmbh+iYPwsCKxWEukdQVh9d6S3RB6D/NcgPVjtr
 QgC1DK+XX6DLYSvGGe/Gox1Lu9OsV3sisTBIjvSlb+evEalkgVJD3/E/Qr1gmybIuXmJ
 5wCBD3sfp3vXDkG/wH8csfol7lcOfChqO+3j+228uujc6P2jO9mHaqV0Pvfbh8gLSWX0
 b3XQ3Yub7mIhm+H938E6rOYgPcghRo5VzM0oB0gsoTdSh7zu4VOeslahMuXG6wv7rkvM
 5d6bNeW7/Rr6lSkAtnlh2cizoaAmZS6mfvRKaRWV6WWybzEtzg0qjBjymiz9Kv+mMzt3
 iGTQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/uS9Ly4as/wMTOl6I3QQTnfEK+uENGbyspVqxhHEw7x4AY8vOWQ98zizpXhVtcxX5EhN9wG5P8MV8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzkNVxoQIJaOWjGCQipBPZ0aZOx7/tWzyxGTMj5k4bFsVF+GnBK
 8u3us/xXoMhiXkXxJPmcWbiEdQUWuLVC4UBxE/2ope3yS/oQY1O5o8wpiz26xdNf2vJwlPCpeda
 kFaCAN2m5xKNtUe7U16plEnMXTvL2EjtVUJB3XEu3q/QY+IJBbEzTd2GZqGcMRq+6yUKjZr8=
X-Gm-Gg: AeBDieuFS4jyjWZwWEhyqy98gNu0V6Adx8xFnU4yvOZL/kNylEGCaf30Vh8QMyof9Gv
 5s211AZDYjMHekALd2sO0DsuntDQLltdp8OMDEIdnyvOojn/v8oZePE8XaNKlGiP00Dn2vA98tl
 MiFzViRDzk/hNTFkcusA6U5JGhchtHKe65m4+5wtLN8joU5PUA+0lBxqUUxz7GMZZjvHzpJgIEd
 UWmIPWz86OPoaNV1g0TVlVcLj6xtxX32AglkpDx4ki/zkTqR1shNVCUjxWMkLIUD0TPsXSYbrr7
 DUqGU0lgRlvmu1iEfq7ChX7CPm54JqnmJm0++BhA6I7TCkE1w0VUj8waIk5y/+FapWEjE80mjqN
 IMbuDxutNYu4zvXB69jZebKKifBhMaNarvGCm/sSq0HmaBCsTcsF7AOi6CXKG+YqeplTYizdv2z
 qtTiSHKSpJkHIPE2T70uHcew7HCAyl4b9YE3QiwNwYkhuCbQ==
X-Received: by 2002:a05:6122:3310:b0:570:f5d3:e499 with SMTP id
 71dfb90a1353d-573a568ca94mr2636803e0c.10.1777405454020; 
 Tue, 28 Apr 2026 12:44:14 -0700 (PDT)
X-Received: by 2002:a05:6122:3310:b0:570:f5d3:e499 with SMTP id
 71dfb90a1353d-573a568ca94mr2636778e0c.10.1777405453562; 
 Tue, 28 Apr 2026 12:44:13 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3924d3ea4d6sm710461fa.41.2026.04.28.12.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 12:44:12 -0700 (PDT)
Date: Tue, 28 Apr 2026 22:44:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm: Don't use UTS_RELEASE directly
Message-ID: <mv57z4zk7usobxokpn2xyevag5rzty5oawk3sojmtyjjypcegz@afqkudsy4xfn>
References: <20260428144553.1103785-2-u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260428144553.1103785-2-u.kleine-koenig@baylibre.com>
X-Proofpoint-ORIG-GUID: lJ0obHxNtC030WoM25CXig3OCIBBK2SW
X-Proofpoint-GUID: lJ0obHxNtC030WoM25CXig3OCIBBK2SW
X-Authority-Analysis: v=2.4 cv=cb7iaHDM c=1 sm=1 tr=0 ts=69f10e0f cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=IpJZQVW2AAAA:8
 a=EUspDBNiAAAA:8 a=Smz39SCUmq805RTcPQQA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=zgiPjhLxNE0A:10 a=vmgOmaN-Xu0dpDh8OwbV:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE5MiBTYWx0ZWRfXyF5X665tQ3EY
 VOw+1UZUV9RoNoR+BU6iQtvkvbWgbnxky3SaOj9Ckdm1RfaLYf0mz1Rz9ByqiOcgT/N68IZwsT3
 uxUUCS++VEoRSdx5aEUoTpP7Aabk/xT7yyxVP6udRJjGlwZVChKNNz/ZKtcaEJkNsy2wPt7o7S9
 0nTZaW3y1cJviXIH7eE9GWi248fGuaqRfbKurDG1q4DXuuWvcdCvJLVx/4AxUQRyhqUv02GUojd
 UQNnGmzuod6my15Y3YL1nZC/3xPpHqGOVAkfa6BzNMU4hIs9LT2DjPySmtuasWJJ1hQxcFb4AMI
 ZHgDUQI85f6Z1ln0aXthRDYZs9nRXwyUKZq0QEc5jSuj/WHd+J2l3YQLKv5aTj9dTYUNhqY407p
 6fXWAHHEFuLFDZvicK3ebdEwC6LDCKbyWeDGZ+WyscsxmqCv9O/G+dFl1Hn8hd+eQSViv52evzD
 nFKltnhAySnZO8ju2PA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280192
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

On Tue, Apr 28, 2026 at 04:45:53PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> UTS_RELEASE evaluates to a static string and changes quite easily (e.g.
> uncommitted changes in the source tree or new commits). So when checking
> if a patch introduces changes to the resulting binary each usage of
> UTS_RELEASE is source of annoyance.
> 
> Instead of using UTS_RELEASE directly use init_utsname()->release which
> evaluates to the same string but with that a change of UTS_RELEASE
> doesn't affect msm_disp_snapshot_util.o or msm_gpu.o.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---
>  drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c | 4 ++--
>  drivers/gpu/drm/msm/msm_gpu.c                     | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
