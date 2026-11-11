Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36705606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AoVmomvi;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OYG041Rp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E94710E424;
	Wed, 11 Nov 2026 14:48:21 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1642E10EA40
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:48:10 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABEKXsS3510940
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=qX3b7mQNELxSpZp5mVmlrq9O
 PoeMPx5UD59wpN8yb6M=; b=AoVmomvizF1l7f377QDbRDNoulbx9eyKJ1YmXZyh
 uvxGsXnNnOu6t78U9/HukjPPHOX54n1EQsc7NM4WPVv7vf3DrpQIDTYKW4lZqSGB
 cP+9wSEL8+muKM83bEKG7MW+ULX3fHhYBJvm4zjjxSFKRMmFx91rRm6PYCD9EPPE
 64j5L70e52VAHg3+q1kEFsks147c25fBjgvvMJ/noNiXZOUfu9lYJTQwzkEiQpga
 VzOVcM7rebK6Koi/JlsUdVBmYlEi37QcsZGRGp6qO4fT+u5NWYWYDxd8FV3smueR
 elpZHOkF8VuxxJGZY9UKSAHRsyxq2pu01ePf2pMqzD0pzg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvt1u83u2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:48:09 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91f0f4c70cdso6175846d6.3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 06:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794408488; x=1795013288;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qX3b7mQNELxSpZp5mVmlrq9OPoeMPx5UD59wpN8yb6M=;
 b=OYG041RpoOSsNcFGdpy+nBMRAmCV69nTrE/dfa/2k8UN2M6Pc3z+8tX/nfArZwtD5+
 12dz96bmcnwpEtPIY3h7+JVYOumq0Ln/WSesjzfer/iXVzLuhplXx/j+b6d6DvYm88kF
 dmsGhe9VyZd6JmCeJxxx2NP1e4CBZQPjm1Pt0Vc8UqoB8q83oH6fywa9Ik6g0x+z5iWf
 PMbWDBf+vYANI2ZuhmYQ67pCdAbeOo5tk2PanmogKDoOA13NqReF68dIkqSOM6uZw+ZM
 Fpg2ezoz/QJN87oRRNI3T6M03qGUiwOttKXQBxdm4J0Aq78W53l8nYz7KM6xgiowzfzK
 JSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794408488; x=1795013288;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qX3b7mQNELxSpZp5mVmlrq9OPoeMPx5UD59wpN8yb6M=;
 b=veQ5h4XOdarVdSDpfFYtzxM+sjNOJPr6Rfng5QMMjCaPfjqfZLDhQ1lJOR/MS32Lls
 d8UZaFcYPgnoHbEXAnP20nGk/qwCeBPomTbrlHaaJwzXXeSArTnkeXL3YnTZ4IwMkhBk
 uGGcujEFyGHjH/c1A/2GxhnRfdB+dF9nHTqeh5M7k7ImKKghrOjAhGTuhFEQyafkHBK3
 C4OYboSHPwoUU/5SfEV0WfHJW1IQPkutpjCh348Bg0eGxiEkdsui3QIICKjg4kyJqttG
 9jl8IRXTZYrhjNOkkVPCw86ZVPxCrwiXtOEa73gCmKQaB2asfC1OBpkXwEpZzB5i1/Nv
 QzdQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEwd+oY6F3ZNhLq7KBVOaoozFe0htbCSXUEvKwUeQHi9eNs2r3ZAp/WIfiUpTvMvS9qJURIpUMuvFk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9gClh75DKdxmQgHKqzVgiw7oOS0L613PlQNNISFsqz7SX1dy81
 gztbjf7J4WN8ZUmwfynHgI29NDq10fnjMtZOZqzV/YA9DSX2CeJQH6B/vxuwffJrpx27PHjH9Ot
 19jW/zZ1FUK20ZUc3dp+2hW7sPZc5STeriz0X4/8rMoS/nX5gkSd7jNe7NL4iW6WNBHd8HIw=
X-Gm-Gg: AYBFou0eVj6Rce4cuSx5CO035dyAFi6UrCDaqRIcyGX20LQY+Uy9aB0OpahdSk0XoVQ
 nrU/aZUunyiqdCy6oS8p0PJZkmSE/RXMuGsy2pd8GUPeTiekDH01q16hK/ra/zVLBfq1O7WXJQS
 lSrlNnlxeIsrqtaDQqsAb6kagM+2+xkG/lQm4sF9v30IaVoQB8dU+W7hd+NGFS6ogI+lhMUr0MZ
 O6oI4rWpsfEiyXrBjLqxaSGOqFaLfcQ44HXz3QMd1t2iqcSWWQN/F2xsghPsm+vrAR0R9zGISK7
 rIsTz5TzGdUSLKws3Ba2mZZ9N1SEeL2HKly1jpJ7AWMRRqAcGfR7W1uTtQ++BUBjPi5d7YJlcAn
 xBnSVJl8+FPEfH7NA7mUQc/w0A75AuHTj4FyMiPlWxd3c8RebwSrxlCMJC761qOVQ9gL0vYamU7
 tCiRfZAPSdGgRK4BC+qlB56mvalP95lty4aEyAcy+7yWnaZzScCxEpLKjan9LhGw==
X-Received: by 2002:a05:620a:1a1f:b0:93c:e83:6ba4 with SMTP id
 af79cd13be357-947afff2be4mr420476585a.25.1794408488450; 
 Wed, 11 Nov 2026 06:48:08 -0800 (PST)
X-Received: by 2002:a05:620a:1a1f:b0:93c:e83:6ba4 with SMTP id
 af79cd13be357-947afff2be4mr420472385a.25.1794408487992; 
 Wed, 11 Nov 2026 06:48:07 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c157b7a63fsm1027158e87.9.2026.11.11.06.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 06:48:07 -0800 (PST)
Date: Wed, 11 Nov 2026 16:48:05 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v8 08/29] drm/msm/dp: replace power_on with
 active_stream_mask
Message-ID: <yff2ymxuchwtpshwleockscsxerjwuy3zmwm3paspu7rvfoyza@pxarnmxbdidw>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
 <20261110-msm-dp-mst-v8-8-d040fb33db5f@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-msm-dp-mst-v8-8-d040fb33db5f@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1OCBTYWx0ZWRfX0nWVa6NRmfG/
 XR+07XAUe7EsZ9iqmuSjLdKdjZkuxZpsnhspV7W8yovQwWeJvseDqwHb6zVxbneCvmckKQscoVm
 AHq1ZN6+coNfwCHEjdl5ORN2ONGZvxA=
X-Proofpoint-GUID: b_APsZHpPNQBSC6f4zGMIY6cA2Kv8aSp
X-Proofpoint-ORIG-GUID: b_APsZHpPNQBSC6f4zGMIY6cA2Kv8aSp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1OCBTYWx0ZWRfX48BgBdfhQk/6
 kBBSgornfzAyQiLy0VaGO/sHuOpeDeACq3ry+OcQ3TJVScgZOT75vOHBbHQh/Bw6uuW6UAh2ebb
 4JICbBWzsn1kwem/W+NZI40WppODk3n0vAQVM35f7hjVpE//ZIkq3zZYGlMW8mwjVqnhfsYuQhs
 1PHG3PtyV+fJXC4xSxMv+3H+nnaL5fPNUaHXiPWFFo+pQjX1UHp4R/bkGPPHpVwubmI5xouAjht
 Y8heq6p8oszVw6EF7zR9MW4EDEOSLtt/n1oksS3hgHZ5oq3joyKjHBlFTrCYbX6FghbWVLrdP2X
 ybAbXlxnn5RwK8/Vavz5195OtzzteLWrM4f9w9NBCqRPDQdv6PZVz9dGIOvdYdMZrMjtpRZAuFa
 pDNFWHCmSQ26VgbREK960LU/7/qg3ukhB34kogVlWep7pPJjPFBQbEuwmM9flcy4KU4QvgkSFN1
 4P9rNy93CQLuwyAmTFA==
X-Authority-Analysis: v=2.4 cv=LvcHWXdc c=1 sm=1 tr=0 ts=6af48029 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=8J1jZnWIjLQ8iHHXRFcA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_03,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110058
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

On Tue, Nov 10, 2026 at 12:54:29PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> The power_on boolean cannot represent DP MST, where multiple streams
> share a single link and its associated resources.
> 
> Replace power_on with active_stream_mask, a bitmask of the streams that
> have been successfully enabled, and use it to track the lifetime of the
> shared link. Link initialization is performed when enabling the first
> stream, while link teardown is deferred until the last stream is
> disabled.
> 
> A per-stream bit rather than a count is needed because two callers ask
> whether one specific stream is up: msm_dp_display_disable() uses it to
> stay idempotent, and msm_dp_display_disable_helper() uses it to tell
> whether that stream ever made it through .atomic_enable().
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_audio.c   |  2 +-
>  drivers/gpu/drm/msm/dp/dp_display.c | 56 ++++++++++++++++++++-----------------
>  drivers/gpu/drm/msm/dp/dp_display.h |  2 +-
>  3 files changed, 32 insertions(+), 28 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
