Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A61606A321
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 20:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o6sfJyHs;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P20TuERi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D452F112DA0;
	Fri, 27 Nov 2026 20:29:55 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12DB9112DA0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:29:45 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJUOET527308
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=wlqOV5YIfDiR1Zs66Hocz3ER
 IUaPwVEuthfmaePx5NA=; b=o6sfJyHsUXzPNj8k0G7YJDSh/yHCDiEnq9pEq27F
 gvyEkhwMhUcHevOiTjjfLD+DiV+sAEdX5LL/B+p4giIun9d8sC8pK/8hU66Z7J8s
 Fn2WHWnhZoXepu3nitkHDdiysJYdd1aV3Pg3xEceHOLCIrFSZsDe/262O8p0pNSX
 37FXPV9rtskzKdyifrLKkDLe+KwYdCdXpHJoZHCxSUOYis1gWdLvA6siF2ROCR11
 Z9OpsAWZwdXoLtX/nyGI6Rfq+aAC76BG//whLkZ7xebL0NqtZdB/aG2xfxSHtZwt
 ZbPlXhtmlpIYhjUx2Q7oPCUeiBXbeXLcapGUTp0v5AsnOA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j7g2dr3xt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:29:43 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9495af07676so1247452785a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795811383; x=1796416183;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wlqOV5YIfDiR1Zs66Hocz3ERIUaPwVEuthfmaePx5NA=;
 b=P20TuERiw3B2AejfRJUO3o7a5ITsEK+W3H3rmim2pDGoABGxFe+7WuhSpC0ee3WJpB
 hlUYPQOKREUbxVdhUndTQWG0NeIlRAoG16xaBm3WtuLurmSWfwi9l5CuVQJYHAIkQ6Bd
 ctH/f1V7Xczfq3+cAiYMRILJTBq4mp980T7Oyn1ce7K6ZNITV9qJXUOcFKLu8CZpP/gD
 yEgy3gn+NMVlv44LS8RtGHNIlVM9d3YM+nkTqlbCWrOeKhLkOvyyh0fOaji0gvqZTJk7
 9GYjV2tU+KIqIWvdifYrWtUo7klU4RA7QrLkNfTBw8Vi4YpAPOoukIRWaQb/0R3SaH/s
 jJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795811383; x=1796416183;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wlqOV5YIfDiR1Zs66Hocz3ERIUaPwVEuthfmaePx5NA=;
 b=bjKR5FgOcg3/dCbXhc+RXG/OCKMhJ6N9plGFj0mRrzDo5UFulDyIoQIgZImku4tUXQ
 ANVg3cJ72rNEonwGq4w0J4ajTgufl3Iv85bgpgGTdPAkc+jtmEPqmPSJCbfdxZ43wOve
 gpclMOnwUZSWOGjb0dsNcWLSILH5QTwhcQS6JzdFD9Mt5ksXEyVYfUDWGjzJfXLe1XHL
 5/QPPWcFBUgBkK+w1iRxg6YPF7i5mEIiGlg2LL1AVoa9OCG9qlLVYr5NsIKTYuxlU7uV
 E1vXHfl2iI/HLq+9Nm/q0s13dlGY9VZ9Mppy3DtO5tSl9U9OsyvHQqxUxyQ+8Qlf1wFj
 0qbw==
X-Forwarded-Encrypted: i=1;
 AL+hErFkgGx8AE5lBYhM9iFRDxfxztPXgkVtO0Kn0xGrgR/O8iRdSRI74VInOXntTd2EAkvFw2NqwgwVb7Y=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/8UsII09NHFTuEIC4eOkyDB3I9EMUHv/5EB/SAe1FsDvQzM4JX
 2P4qbYjfEK4Jln0w0LquTBNGFLruqkPxxJIgaiUN1FH/WflxspDCK0ua0F20XvPwKZ2cVSlaq12
 iqw63JxuLAYaOKNBEG4x1SU3npbgbG6YKTa1qUrghg485+HsAH2TlyCM0pQ76x5wRehsGrHg=
X-Gm-Gg: AZFdTZfexA5Ed+M34ggvSCAt9w4epjJMT9XdTAgBEGG5fHm00GpfHTGYUlrofNTCXiX
 PVP0sbNbT7uA324Rnxqx36/eA0Ew77ssu2U2WObrzyrz+PZTtFBo5GZ7R1utXpLeQX6JU1RfUk+
 KOi4W65sMIDnJOH4Rff3RpuMrciWvcpB2aujdsVtunHmKR7ebnHyKfVM87U/0MC2BwYil2wBSmC
 mLSdqySsvo4hDpFzOAnqGZjJRXby8hbrpV6HmNRMBRPnpBGvnFuZofg3a4nsbjuS3WmtQnfOFoo
 tjV0xI9C1kWFXVzy77TlHiH/hRW8YQVgGjN7famJxojheTdP5X0d1U1YgKUtwPhD6ejnTfen1T5
 uQsHG87Rn94CzSmyKm2HnwZPuADZdRbaJhsL69RbwwqVw6hQwIQlxaCXGtmNvgm7n4t2bk0wunr
 hMJ26yD11smxSgaOTSaco4sV3P6I0pWjPQElkFbbl4A0PMYQJj2pOQoDoxe8wzyQ==
X-Received: by 2002:a05:620a:4404:b0:93f:19fe:e6ca with SMTP id
 af79cd13be357-949ba9aedf8mr4771516885a.43.1795811383278; 
 Fri, 27 Nov 2026 12:29:43 -0800 (PST)
X-Received: by 2002:a05:620a:4404:b0:93f:19fe:e6ca with SMTP id
 af79cd13be357-949ba9aedf8mr4771511885a.43.1795811382791; 
 Fri, 27 Nov 2026 12:29:42 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae80537021sm59515951fa.28.2026.11.27.12.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 12:29:41 -0800 (PST)
Date: Fri, 27 Nov 2026 22:29:40 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vladimir Zapolskiy <vz@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Pengyu Luo <mitltlatltl@gmail.com>, Alexander Koskovich <akoskovich@pm.me>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Kavan Smith <kavansmith82@gmail.com>, Jonathan Marek <jonathan@marek.ca>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
Subject: Re: [PATCH] drm/msm/dsi: Fix TX buffer pin leak on command transfers
Message-ID: <as6giojrugjm3mftrurba767waiclzbdyc2rhnnpaqzlkimwa5@kkod74wmdmwv>
References: <20261126141942.335280-1-vz@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126141942.335280-1-vz@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4MSBTYWx0ZWRfXyx7WSHhRolsf
 4Adf9AobRBViU6FBbIzUhMy8/+JH2pdAWGGafq6IYtr1axKX+EGsHQLTkoM74WrYgv8dPhJGZJJ
 nUsEhUn/ZJnf+9dfJsKQVBH8g68PlefmnBGgp4nNaaJTfPod5LrEOqlcfwps1LYFMltvM6en+Ed
 WFhj1FQih6/8LLmlGM1/wAzIKw/YafvgbAyoX2LLuNdYlGIoRXoPuGxS9u05gARiHLveCf4d1hz
 dRfOW7F+rs4dK4JLeKeVTAmUaEPaXZHvgz39pHPdzRU/sA39EZypef4FHYRTtz+Gn0unIB9KgnE
 gVNoTr82YMv00rURYjbOmpWVCPw0+OF2JY+8Sa+YtyaFYckIPQ44YJetBCPCu7jl2ihEiAyq9+p
 kcqApJPr+ELAA9HyJGpHZF2CuXEiKRAeiELov4InPyKr2mRg2dS3wCmuslD8UmrXcxDfs9MwTHx
 TDdszmeU62t9YM7Qz5A==
X-Proofpoint-GUID: VNhiYyKGKf5V7UEGfnirikBJzQ3c8RMS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4MSBTYWx0ZWRfX+evlhNuN80P8
 nY1oSBMompXe8RLNE1VUGPl+ojBeNKS1QoRVtLJSdc7yDCkqvlDoB2z6RC8SQSTWCBGEYyoNkCy
 KwSLDo4Xi9BflR3Yw5/MN1h7kEAPuMQ=
X-Authority-Analysis: v=2.4 cv=dJEzC+Zb c=1 sm=1 tr=0 ts=6b09e838 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=3kaI0MaazNZqiMSrzYAA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: VNhiYyKGKf5V7UEGfnirikBJzQ3c8RMS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270081
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

On Thu, Nov 26, 2026 at 04:19:42PM +0200, Vladimir Zapolskiy wrote:
> The DSI 6G TX buffer is allocated by msm_gem_kernel_new(), which pins
> the buffer object in the KMS address space and returns its IOVA, but the
> returned IOVA is ignored. Instead dsi_dma_base_get_6g() calls
> msm_gem_get_and_pin_iova() on every DSI command transfer to get the TX
> buffer address, and the buffer is never unpinned after the transfer.
> 
> As a result the pin count of the TX buffer object grows with every
> transmitted DSI command, and when the buffer is freed by
> msm_gem_kernel_put(), which drops only the pin taken on allocation,
> the object is freed while still pinned:
> 
>   msm_obj->pin_count
>   WARNING: drivers/gpu/drm/msm/msm_gem.c:173 at update_lru_locked+0x90/0x98
>   Call trace:
>    update_lru_locked+0x90/0x98 (P)
>    put_pages+0x8c/0x104
>    msm_gem_free_object+0x1bc/0x244
>    drm_gem_object_free+0x1c/0x30
>    msm_gem_kernel_put+0xa4/0xb8
>    msm_dsi_tx_buf_free+0x2c/0x64
>    dsi_unbind+0x20/0x40
> 
> Save the IOVA returned on the TX buffer allocation and use it as the DMA
> base of command transfers without pinning the buffer again.
> 
> Fixes: 9fe041f6fdfe ("drm/msm: Add msm_gem_get_and_pin_iova()")
> Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
