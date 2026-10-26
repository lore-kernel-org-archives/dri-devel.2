Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C677606B47A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=duOPPQmS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ioZYd1qY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85AE910ED7A;
	Mon, 26 Oct 2026 10:00:06 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93AB010ED7B
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:59:55 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4aZ2L2222712
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=EihPl48XyzquhIbKjuEyAajD
 35LkfbvtwIfgKv80/jQ=; b=duOPPQmSNBtx6zhy2MyD4npHJuJX7Gm6wHBXP8ce
 gso6SBXwNnKeARLD/e0CobapPe+Pf7ies1PCMX8l0Ug5iwRxIVau+SXTqeR4fsTE
 bPqNxK1Bfn5d+FDp8KiVM+Bp+TZkWsYiaO5Dxo3FHoaEt9Yu7ndZYJNRki6RGyau
 e9TqyPtI9Gei8s75Mu/XbJ23qlTZsPaJIRg3qr0eUH6Wvuq+DaaJU5SFPTDHFggF
 7OibQZR51kSYWjQNBxzIW8c0qzGWVc8rErJCz0VI/N1iO4JE5O3EbCK0hg/I3CsL
 BG8uaN7ChjqvVzPqPBbYVSwVAksgA7o7Ey9Rzt7q1IwiOg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhvdd9jwv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:59:54 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7cb9d27ddcfso412028137.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793008794; x=1793613594;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EihPl48XyzquhIbKjuEyAajD35LkfbvtwIfgKv80/jQ=;
 b=ioZYd1qYied81Mtz2b7ryMnlrRr7n45VN+vN9RTCucy2XHlnW6S+uDid78L2H5C58+
 buC9codOocO6IRjCyQn5icE/MoFMkkogZg5OsxjXS5t95tKkkbcswPOmVEnmB+NdHVQg
 0RdRJWNEiBORsJYVfFcVAacL/bHKwTVZK2zkC8LX2BqwTQwgSr44niEzX1+1EQ2culSl
 R264x4iPSURFCciVzIJ3+nh2PHZyZW3abM7tVsCWSQA0LvqjY9BGj0wk7KT7eXJXsXiF
 q8FfeJmhOto9DN0/nIvZ2Le4dg2NGvK1QRTemEGW6/mIZfDugV8InzdUPBfZ/aJiYrR/
 rIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793008794; x=1793613594;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EihPl48XyzquhIbKjuEyAajD35LkfbvtwIfgKv80/jQ=;
 b=KMYfjUsTP0mjfs6iMKWHYsGXSnvZHRt6fxIMCYZPjBUPTigBexyPmaXmuVYYiSTZIl
 U1SN/R6mC8cZqKtfhLPtJKKqFME8E6uvIfWJsUNBwV1J9sOIFNx5u6qrPA99xWvK2yIh
 vEx7l8gs5pzuEojGXv1bP4hTt8p9z+hAYPIUXGeDfDgvJvnDfnjCAs9HBRFWpnBNUCTO
 dFgOW+9r3y4f7wCRmMYn0Z+UdtnqN6i+T097d8+5k4uon4hGF+9pgRJ0A9uJSwv2N/lT
 EA9WihhjwJaSzX68b/ZQcdCWzvFLeahIItI5/pW0NcNReWmuyBUGT9ReuAYvKHRLxxK2
 yUsA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy4Krt3hGlkPnrXi0xlK2wuk1Cpha9iQUPFgZ3OtVJ0FoBfsb0lwBLlPRkYv+6UhUi0WZvAp6s+IWQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI/sCwwBeYEB3PGAKGW6LLQWCDG6jqwzJs7HSEyz50jXz6fHa6n
 disi1uWga7b3qG1jtpkEnUva/WXyHWkyZL1WT43rGSHXYDTB+LowUrNT9wHV8eTjKQab8Ds69H3
 Af2cw/DXflTUjfgP3NDlYZXde5YgKXcPU+cpb+8DuMOH2MKxoNn1W4zMBNFvAIbQ7p9rAMkw=
X-Gm-Gg: AYBFou2hajf2Xmb9obJsX7g6IUoMsEf6euMRmxu2e+8P+YbTrWQHURR3JpRLkJH0u8Q
 FfkS48re9pzaP1Lg3tj7WJrFWzUE4kD2NzQ70dGTncmX4uZrp59Z8/AM+1+5DzadD9cD6P/FPTr
 w+SDqW9aE1lcOBT8oRySV3X+b3zvQv1uyg4dX7W5PEyRk5qdhV55PYzIOYEvezmu+i34e8j6Tbq
 lH7ZCAjBpQVMM6warnCO8BiAlVBeQstHg5DqN1EngXYhnvZqtD0EAavy/R6qiyN+f0qSDHlSvEI
 bOJUOyR523jZWWacLEZ092y9qRLTxDKcEXhSHnZT1IPWMrQ+gfGSSz3LlX9rfNDs6/py3XN/PIM
 PYdL8SumApMVzwo22U4M/38Ei53fu/n/RVjAdx2BYiFGOLrShP6I4yMwunNTryR7bBwcpkZFJD3
 rRdZzfxoP5aZ13
X-Received: by 2002:a05:6102:511e:b0:7cc:2fd1:7143 with SMTP id
 ada2fe7eead31-7ce5cd65a0fmr1586643137.17.1793008793897; 
 Mon, 26 Oct 2026 02:59:53 -0700 (PDT)
X-Received: by 2002:a05:6102:511e:b0:7cc:2fd1:7143 with SMTP id
 ada2fe7eead31-7ce5cd65a0fmr1586636137.17.1793008793315; 
 Mon, 26 Oct 2026 02:59:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac709d0606sm16973671fa.14.2026.10.26.02.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 02:59:52 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:59:50 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Flemin Jose <flemin.jose@oss.qualcomm.com>,
 Mahadevan P <mahap@oss.qualcomm.com>, virtualization@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 18/23] virtio: Add Qualcomm Platform Services Firmware
 Interface ID
Message-ID: <lisaligvjmnnib7gm6klab77jfzyagn5cx5pix3isodu2cjvrr@o6efvpyte5yg>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-18-7cf014efdee1@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-18-7cf014efdee1@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: rYv4h0WP-o7NA8XQ54a0Ru89ypEJRWcT
X-Proofpoint-GUID: rYv4h0WP-o7NA8XQ54a0Ru89ypEJRWcT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzOSBTYWx0ZWRfX5ZkOiTMd7T4G
 +iOti+JX1x8eqE4yAQ4UBZtKhGzkg6fw7uq7Htr2tGtp6H/GGb9Q/SXu0LwgSheQ90VCCbhghcn
 Vga+Vo0FnFlY0vt1J3L5kWULPJo0dbniP0Luh5JBzGKKY6rjrkHzTii0zMQgbVddnAV3rg8Ai70
 r2HPWh6KBAO4/N4RIn7HMUGrWCXppduPIrJ2kK3UUMvryB0bByWs7s4+stnYMqG7R98PDmGt9Sv
 8mwVXDqIA6Z25IyWvUFMbnW9saHTO1dSw8DrZDOdyLKuifL4jbfvWHapjwz6DMcH/ZqXxcwSkgU
 HTVK+HFC2JJUxKgMvlNC9Cf6pAhX+q8c4J69LpTugWYF2ZPf8eVchVsex6xtOmdL/DlVraTSYVR
 EGyw5phBi4T9X3IHRZDNJpf8hm5xBVF7gAe5ZySC4Hqly0PQz7qAjIUeACArPw/0/cwViwF15i4
 TkGaEdNWHD1K+AUwT1A==
X-Authority-Analysis: v=2.4 cv=N8+8hG9B c=1 sm=1 tr=0 ts=6adf249a cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=dTofmrguFlo4DCddnn8A:9 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzOSBTYWx0ZWRfX7izsvMS21Uv6
 hlFL2ILsidD/g8cCMjR+YRpXIFJ0IIY6lWYVWq4wdwwuVzLIZK/oojZ6PSHd2a+RbEA1kftnXg/
 iop0vpcfYS+w2IijZRdaFmbXOcBwxoo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260039
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

On Mon, Oct 26, 2026 at 11:51:28AM +0530, Jayant Shekhar wrote:
> The Qualcomm Platform Services Firmware Interface (QPSFI) is exposed

Can it be anything other than the DCP? If so, how would you identify it
on the Linux side?

> as a VirtIO device with device ID 52. Define VIRTIO_ID_QPSFI in the
> common VirtIO ID header so transport and function drivers use the
> shared identifier.
> 
> Assisted-by: LLM
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> ---
>  include/uapi/linux/virtio_ids.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> index f9056af0c622..6c6f283733b1 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -70,6 +70,7 @@
>  #define VIRTIO_ID_GPIO			41 /* virtio gpio */
>  #define VIRTIO_ID_SPI			45 /* virtio spi */
>  #define VIRTIO_ID_MEDIA			48 /* virtio media */
> +#define VIRTIO_ID_QPSFI			52 /* Qualcomm Platform Services Firmware Interface */
>  
>  /*
>   * Virtio Transitional IDs
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
