Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8891B606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YG0tSt4W;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=drfltoHZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF2361129E2;
	Fri, 27 Nov 2026 11:53:53 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 255CF112A59
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:53:43 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARAp6nU2268585
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=h1q6px63hWFp2BtBbqQNwKX1
 6JMwBQoQCIz9pZSqqKo=; b=YG0tSt4Wnt3sw/KXZyt5Sv1Nf8Fxpqws+IcIJj6m
 4whyWDwZ3D3WM4KVOMjhVDSNvWduLKsCRuwypiMqsU45hQyvxtpVYWnPN/igNdxE
 JBAwYmNe9Diyn5oBipi52RloGJk6oUoCpgW47tuAhLWKXcQXTS0LNwNu7AlghWnj
 Uw9/ig0D62O7daP2xAr3Y5SqFZPlZTuUa3K6eAwCPmZUJpZLxdUrnFKT1uxULLz2
 3OlrzIXA+6EejWi81i9QLJjyYWWFQrr7kRE/4NSZsHOQXsFrzJCG53XHU0wIz7sj
 +dsopKMPaHFFtjt/IXoJOFP/t+7knJ0HY5lAXwsTso0oPA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j73uhhfdt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:53:42 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f26dd2165so1923250685a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 03:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795780421; x=1796385221;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=h1q6px63hWFp2BtBbqQNwKX16JMwBQoQCIz9pZSqqKo=;
 b=drfltoHZtxnyI3Klt28MVfIgkxB41/y/YuTQpLc0iogUGXMFPGECcLl5L+zg7MeVBZ
 UMsuCoLj0BBYf451W4CTLjQT5dtEPLERYQfOU7seiGfZn+0tgJMVczbrjCAqOr8Jwex+
 9oWZiD8l/YRXm11GtLPQKvZ/DQbGGp3CTMCyRR9UQlJDBrMk2Wim9Yt+s0K7r83hZjpg
 Nr7/ClOAJbF8q/cxQebu5rtkDFaLRZmc8OYOSr2SO7nxYhjdS0PFyc8KZdERczebShgt
 VMA4I7atxKKkZ4NkINz7mo6d1U0yYJNVbiIY9kCOXjdZdy9Gq1Syoqrjxf4OCc8v33HO
 uWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795780421; x=1796385221;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h1q6px63hWFp2BtBbqQNwKX16JMwBQoQCIz9pZSqqKo=;
 b=au8Q2TD518TvwNyaUIR56q7v2/S37PnMpzESbKB+CdvBBoyEW3oL3BWGxNM48uyKqQ
 cMnoyq1DQbwBAWpSQfXXhBjv/0hF7cREusrEjH6qlC7xsh4SogSVvGykIPjJ2B/yR2Hl
 SYNK8sp3oc29TGHANoqJusp4zAd+lTp+mJ9gSkN0Es4VXuNVwKFsri9CyfgCzEgxYk4z
 7fbC12wueMz/SunhL12k0dBXsvselwQz8I212vh4OuYKL+UT7NC4u88DM30YOGAAwCai
 3rohXFhdoyzNzES4c2Hq6CmAZQX1BDVR7+OKv7h4tVLvT/L/SxIKsJmafK8qavzgGoVd
 +KAA==
X-Forwarded-Encrypted: i=1;
 AL+hErE7haX5BBEZ6CRpYfIioae+8KSpayBL994Qd9IviMXAd9MsE8FtctW3mTs4tuhdZ5nUi8x3KbtTbk4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/SQqvXoX0Eb7xqYreY2/0RRfDl5VngYe96fc7HvqVsobg9PE6n
 xtOr27H3Qr58nrU+mXl/NOn8MP/UouuS304S02ZIrFwToK5gAq30vcRRDeR2FDNS3qFcmFiuhgt
 zehyeSaB9+vW6FZQ5178X405IFXXGNjd9VBUhDfxPpIeTA3vkasaTxDLcWojPCgVbKZT/OGafsf
 0iucSf7Q==
X-Gm-Gg: AZFdTZesk4RKIXeoL1dehr6f+7UrVnnnHjX5sDoZD5rxd4C6Kw9IFyLcRGvyFawSYyr
 1jmB0ABWK9paTGSzvSFrnkLl4tog/gn/awgoVt7xM5hP3zGnY5FzRGmNb4wvpqADcxR6H5JCy/c
 CSoPeH1EIVS9kQWlK13q8cQul8Q5F8+KrCcXNdlSAxCcBtqqgi8Pk7UWTyd/ti59xdP2M55dLFG
 wzkYHxhhRBccjnM2UmIhNfeCqd+11hCbD5FLZRMws4TDkHmfdDjwjp3M6Cg+QwWt5hvc0n+jAkl
 ndHJxCO2yqV/QaPLZO+8NrO+FYOSqqogVjBGb73Kyy9oi07Ty81x73eY3GeoBsmSFOlLHVb2vaA
 vIhDbKmG8ehPAu2Xddw2lb5QFon4V+ysTtWvGatgDH6QaZoCFenWQz3YbBmfF+Teab+vA1W7Rzi
 p8jFILLgpfvNz+/DjP5ADMT57/Fx2nGJyKG7M2xpjyb24c0R8MQtxkFXLvE/xe8g==
X-Received: by 2002:a05:620a:2b45:b0:949:a7d0:9fbd with SMTP id
 af79cd13be357-949ba9e2668mr4432217585a.41.1795780421472; 
 Fri, 27 Nov 2026 03:53:41 -0800 (PST)
X-Received: by 2002:a05:620a:2b45:b0:949:a7d0:9fbd with SMTP id
 af79cd13be357-949ba9e2668mr4432214785a.41.1795780421031; 
 Fri, 27 Nov 2026 03:53:41 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae8055cf80sm64383021fa.36.2026.11.27.03.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 03:53:40 -0800 (PST)
Date: Fri, 27 Nov 2026 13:53:38 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jean-Francois Bobier <jean-francois.bobier@laposte.net>
Cc: linux-arm-msm@vger.kernel.org, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Xilin Wu <sophon@radxa.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Saim Shujah <saimzst@gmail.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] drm/msm/dp: validate modes against the trained
 link, not the sink's claim
Message-ID: <bm5qadv5cuyfdeu3ggvwmme4q4rj5bsr6qur6zr66ciq2jv2fn@2vq6f57dyf2z>
References: <20261005131432.22840-4-jean-francois.bobier@laposte.net>
 <20261005155615.32923-1-jean-francois.bobier@laposte.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005155615.32923-1-jean-francois.bobier@laposte.net>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0NyBTYWx0ZWRfX2jFw87UMMQi2
 z33tvFesly+lk9Da6zPsC7e6BcKGJ6MMEyTDgzbwhi4hZ+8x2ZLKT//fASQPA8Jo2RpzKywL/BB
 Uk8KUJMT9x26bUliUbvMfP429PrrUTk=
X-Proofpoint-ORIG-GUID: D8cFH9IXM6J0TR0067-n1yZL6423SSi_
X-Proofpoint-GUID: D8cFH9IXM6J0TR0067-n1yZL6423SSi_
X-Authority-Analysis: v=2.4 cv=BbBNQbt2 c=1 sm=1 tr=0 ts=6b096f46 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=AVbMHacnAAAA:8
 a=EUspDBNiAAAA:8 a=SNIH7UutgQ7Xh_Ke57cA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=Z8w8RPyABVWp4NBWd0ke:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0NyBTYWx0ZWRfXyMUCuXjzjb02
 WCEJ6sYrtaB92ZTw+9gpmReFeWatzDxIHhESmSoMkiz/nq+ZB2Zt9pVLVmuWZABiiqIFgweMeKE
 acmlbIKTXaLSqj2O0jbQLexjGAsqpJ3JrF5HpHeljtwGIGd0D7a3FwZtdKVT3jOmuRzr7UeYMLM
 3PIOTZC0MfqryJGuY/R7lnTZY1CSWQMA632LFZrPCvLajPE1iTrBS37c3PP+M+6iye3HvBhZPfd
 4SCbuZ17m+gB/SBCXgfnfgkRA7gzTrTsgbax9EaKjG8HSmkFCQdIYyVRh7qhceuPhplK0gEp7+B
 +6fd3z7cH0La1zGoRJixZlJbv+WqdCdX/CL+vFCOaYMEW9jemNcGqWnkeh8helrIBHw0o3CgdSr
 YqqWzNBEE+/1absT9kicnZnM7hIF17cRFOR4J/UWcPF/00Y1wC0Cy6ms01BoVSdTBtlIsXO/Gh9
 +ttXX00BegooN/CldDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270047
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

On Mon, Oct 05, 2026 at 05:56:15PM +0200, Jean-Francois Bobier wrote:
> msm_dp_display_mode_valid() sizes every mode against
> panel->link_info, which is what the sink advertises in DPCD. That is not
> necessarily what the link carries. msm_dp_ctrl_on_link() walks the rate
> down HBR3 -> HBR2 -> HBR -> RBR and then reduces the lane count until
> training succeeds, so a cable with two unusable lanes trains at half the
> bandwidth the sink claims.
> 
> The validator does not know that, so it keeps advertising modes sized for
> the sink's maximum. Userspace picks one, training "succeeds" at the
> reduced parameters, the mode does not fit in them, and the sink shows a
> black screen -- with nothing in the log to explain it, because from the
> driver's point of view everything worked.
> 
> Observed on an sm8250 phone with a 4K monitor whose cable only carries
> two lanes: the connector offers 3840x2160, the link trains at 2 lanes
> HBR2 (8.6 Gbps after 8b/10b against the 12.5 Gbps the mode needs at 24
> bpp, more at 30), and the screen stays black until the user picks
> 2560x1440 by hand.
> 
> link->link_params holds the trained values, but is only meaningful for
> the sink that produced them. msm_dp_hpd_unplug_handle() now clears it on
> disconnect, and msm_dp_ctrl_on_link() resets it to the new sink's own
> maximum before training, so taking the lower of link_params and
> link_info is accurate once a sink has been trained and a safe no-op
> before that -- never the previous sink's leftover values.
> 
> This does not by itself make userspace re-probe after a fallback -- that
> needs the link-status property, which cannot be set from
> msm_dp_bridge_atomic_enable() because the modeset locks are held, and is
> the deferred work the existing TODO there refers to. What it does ensure
> is that any probe after a fallback offers only modes the link can
> actually drive.
> 
> Also log the rejection at debug level; a mode silently disappearing from
> the list is otherwise hard to account for.
> 
> Signed-off-by: Jean-Francois Bobier <jean-francois.bobier@laposte.net>
> ---
> Changes in v2:
> - Clear link_params on disconnect in msm_dp_hpd_unplug_handle(), and
>   updated the comment in mode_valid() to say so. v1 reset link_params to
>   the sink's maximum at the start of training, but never on disconnect,
>   so mode_valid() for a freshly plugged sink -- which runs during EDID
>   read, before that sink's own link has ever been trained -- could size
>   its modes against whatever the *previous* sink's link had trained
>   down to. The num_lanes/rate == 0 guard already in v1's mode_valid()
>   now does what it was presumably meant to do from the start: treat
>   "not yet trained for this sink" as "don't restrict," rather than
>   "not yet trained since driver load."
> - Caught by this list's automated review on v1, not by hand -- credit
>   where it's due.
> 
>  drivers/gpu/drm/msm/dp/dp_display.c | 53 +++++++++++++++++++++++++++--
>  1 file changed, 51 insertions(+), 2 deletions(-)
> 

Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support"
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

)

-- 
With best wishes
Dmitry
