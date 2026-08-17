Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776DFC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 06:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD87B10E676;
	Mon, 17 Aug 2026 06:58:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WvjKzKS6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OaToO5wq";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A587310E676
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 06:58:06 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67H44OQI1175358
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 06:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=SBRrabcYBEIHtygqtEKhQW0Z
 lUPvQs3RPnhnKjeoIdY=; b=WvjKzKS6qRwZItZ88u09pS5Z6G+fORseRx1d6A58
 lj0rfbvKkjjQrvUuvpCDbnJ4LOuKnkaYZVZgPB8Nj5aHW+mW0DBKjhX/FhaYLXjk
 qjA/QbRWnA5nxpiSWq9vMFjKidb0HVYQBJE64FEbkqTHnP+SdHIxK5d5T9D5DXr4
 jw9yL5CgJbbng9gt0M/PwgTMGNz5Z831gaiGoluNwLmYcRBtO2ByLBNseZvy4X/d
 bKRtfIPIiXJ1q5N60gR+uYq7gX4eDJgyE86lFLKTJd8MmBAtLt08pYWuqcPbiWCd
 nskBHBZ2kmXKO7zV8I1mNf0Xhi+lyn81+Yf/p1ihxrzlvw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3txy8h6w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 06:58:06 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e53b8a302so320320985a.1
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 23:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786949885; x=1787554685;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SBRrabcYBEIHtygqtEKhQW0ZlUPvQs3RPnhnKjeoIdY=;
 b=OaToO5wqGFteWSX6EfPgLcU0BPUHOQ9jqDN+5nKYZdcFda+zmJQ7f29i+ND3ai8NBh
 tkzFPjo/7mFMfiKHuQV/gwdK5L3whkhuLX6bKqMKWrxRvJvf1fRWyfnoL4d7BI/CrVMO
 doDw+Qm7dXxvSkf9Nlg41dtbBvcOE+EcU4BccC2Z3BO53YY69pDvWMeMv+wTe4SocXzG
 i4XOOz0whdrDVFUP3Z6E57PTBAbXT9QmyUv8CAWbTWprI73vC8nENq6FvJ2Igst+yf2R
 girceO65avfSHiPnsGhKi4hBBRWWEydCHuXUyMXRTq/Dmipl+iMVQYmscDN/CqSywyPi
 VSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786949885; x=1787554685;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SBRrabcYBEIHtygqtEKhQW0ZlUPvQs3RPnhnKjeoIdY=;
 b=c9o/kMtUgbpgqw+MPiEK8Srmu6PThnz7Q6Fdnu7tFMy5NYhew+6HKcWyaZB2vJdQ56
 GnMQULf3BlNmNozUETLWIuiWtTwmlUaaR99hYbs7rcdhAk3SBPU9N5ix4hmpkRYubEBa
 usgb1LNVR1DZ+cPkzt9wDQkAaWDJLmQWKoGkObpOBLb4w+jdqCXyp7s9AdY+E7FXxXcS
 9mS4OEIlTAdaspMz2C5fWy90hh2DOOzplyDWxrf22jX/dP4+qSnLHOMYda1GdYnZcYtQ
 3MnIifTsPMKJsULiy6xnpQ4jgANWQKkU2aP/L8rbEaAZB8dIPTNQJiHhSuYSVnym2aB/
 o8QQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq6G4oL2jazExO5cIJvr0qyJnkQ7zbCS8RLlMDEWhqthWx4U8b5/A/Tu3CkOYw2oOYzzNlWqOzF9Mc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwC8mDM0SsR0bofEJ9zja23q/joKENUsbLRenZfzyZFuSsYsIXm
 TgR0pvWr6PFIz5X1ReKkvfmXrbfYqCYdKg+1krY3T7Fd2BZYUTX8irAdh/Z1FXChiavdk7DLrEn
 2a0r1sSUG/NE2AjmEqatTu7U6jjbukwEzy7e1CKvwgcGxvQZqv2GP4ORWzk/SjCUIkOpuZxM=
X-Gm-Gg: AR+sD10ZaSo9qLtapsrmkOwEbPOuso31RhO6zXkwSsB2C8qQa+YVjKaBhmJSiRPvA/4
 o9bgqadNIVwP7qUx7K9Z3eqj0M1Die0PdcvfdaeGWVtHxJSoSJW+CR2gpiY/MQwLp6RDRyVHlGG
 t9rfYHyivFGjRs786R1/uN/IDUoaaF21/Hpi8mAcwXr7DPLj9mukA4ZmYpK//89tgPrAYvPpadN
 6NmAbubwY2xVJXhZEnVX3T84sI3kbiwfdHeAQoTcUbkD6v9dl5GSIJ3P/604BsrtyyjgttrCJVe
 1X0NNQY4Ib8/qCyNfP/G11uX7kgLMcioWmHc/7GtTuu7JHWs8+7rHaewqtIpALi6BylVxQ/3NCP
 jk79fZSENJpCUxW7kvlpbRiLzyM9mHeGeuNG3G/QIFHwRFp/w17kKgDfjUggqr0F7Ijm8U9RI6z
 37+sCmngldeUIS
X-Received: by 2002:a05:620a:43a4:b0:92e:b1ca:8ea3 with SMTP id
 af79cd13be357-936d2356ef3mr2575749885a.47.1786949885105; 
 Sun, 16 Aug 2026 23:58:05 -0700 (PDT)
X-Received: by 2002:a05:620a:43a4:b0:92e:b1ca:8ea3 with SMTP id
 af79cd13be357-936d2356ef3mr2575745085a.47.1786949884607; 
 Sun, 16 Aug 2026 23:58:04 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b46d02851csm139928e87.84.2026.08.16.23.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 23:58:03 -0700 (PDT)
Date: Mon, 17 Aug 2026 09:58:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2 08/15] accel/qda: Add QUERY IOCTL and QDA UAPI header
Message-ID: <r7bx25akbxomzhxxyqd644efy2vc65etwcnhlyha7wm7xrt7ea@p4v5sesn5rzw>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-8-69a02e9090d4@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-qda-v2-v2-8-69a02e9090d4@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA1MCBTYWx0ZWRfXyShBAy49Ez5o
 rtONfmJJtYluWaTM9+AR6u6QohgRzwlivJ7UZPzGzotTWEMPgXhNRI8kXa2pmN/1T2E5AfUbw69
 vdUkNFGBcE8AXi7RiOcFTP/TwQRCeGc=
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a82b0fe cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=WSzJgX5NAZKvnqDBNMEA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA1MCBTYWx0ZWRfX3iCeyFXpQlDZ
 Sjwb5EffnxGGvpdeZhmXpWhfLm3UXgwp9hiam+mDxatRJXWXDaAyppaxUu+CWmKQshIw9Zmb1Ep
 1icRHMPPW5/UipJtn0K7IKBJT993v39ySBSWISlHaLkpCHgL2sB8MlP4klTQWozVXhV/iP3HvLD
 W387nRt9GR5cAHvPd5k+BZN6Zz4YPXjVPnusVnlw6uIPRtIO6Sto5gBxZ+38fYdLFMo9xO3isbc
 6CXib9q74F8RKBZz6J+CpAEEKgXhpQN0oi7M+2sXGkmeCR2za/wzVBFZKzZJtVNc6rr+dwG3DOr
 MNm3OD9n/ZsXkHBt49F1g7Umqzm3nkg1qOHo5hnMhkB3EemcCLzWL0M20gCuWbin2O/DWeXkxtD
 x70GvVosqbPd0wQ0w4RYt9zDwVBUyzNHW+fOIHE6h2kkuJjzUzaN+vc2cL8AcQR3ZZA2DCSB9At
 n/n0LLFTlGUB6cSuq0g==
X-Proofpoint-GUID: yFc6pWlICBc5k5l_WFhM3D70VAO9YpiH
X-Proofpoint-ORIG-GUID: yFc6pWlICBc5k5l_WFhM3D70VAO9YpiH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170050
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

On Mon, Aug 17, 2026 at 10:17:43AM +0530, Ekansh Gupta wrote:
> Introduce DRM_IOCTL_QDA_QUERY, a query IOCTL that lets user-space
> retrieve information about the DSP a given /dev/accel/accel* node
> represents.
> 
> The IOCTL takes a query_type selector as input, so it can be extended
> to return additional parameters (capabilities, attributes) in the
> future without adding new IOCTLs: drm_ioctl() zero-extends the argument
> structure, so new fields can be appended to struct drm_qda_query as
> long as they go at the end. The first supported query,
> QDA_QUERY_DSP_NAME, returns the DSP domain name (e.g. "cdsp", "adsp").
> 
> The UAPI header include/uapi/drm/qda_accel.h defines the command number,
> the DRM_IOWR IOCTL definition, the query_type values, and struct
> drm_qda_query. It follows the standard DRM UAPI conventions: fixed-width
> types, a C++ extern "C" guard, and GPL-2.0-only WITH Linux-syscall-note
> licensing.
> 
> qda_ioctl_query() validates the reserved pad field, dispatches on
> query_type, and copies the DSP name from qda_dev.dsp_name into the
> user-supplied buffer with strscpy(). Unknown query types are rejected
> with -EINVAL.
> 
> qda_drv.c registers the qda_ioctls[] table with the drm_driver so the
> DRM core dispatches DRM_IOCTL_QDA_QUERY to qda_ioctl_query().

Please tell your AI agent to stop describing patch contents. Ask it to
describe the reasons for the change.

> 
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
> Changes in v2:
> - Add a query_type input selector so the IOCTL can return different
>   parameters in future, and switch DRM_IOR -> DRM_IOWR so the input
>   reaches the kernel (Dmitry Baryshkov)
> - Reject unknown query types and a non-zero pad with -EINVAL

> +
> +/*
> + * QDA IOCTL command numbers
> + *
> + * These define the command numbers for QDA-specific IOCTLs.
> + * They are used with DRM_COMMAND_BASE to create the full IOCTL numbers.
> + */
> +#define DRM_QDA_QUERY		0x00
> +
> +/*
> + * QDA IOCTL definitions
> + *
> + * These macros define the actual IOCTL numbers used by userspace applications.
> + * They combine the command numbers with DRM_COMMAND_BASE and specify the
> + * data structure and direction (read/write) for each IOCTL.

Is it not obvious?

> + */
> +#define DRM_IOCTL_QDA_QUERY		DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_QUERY, \
> +					 struct drm_qda_query)
> +
> +/* Query type definitions for drm_qda_query */
> +#define QDA_QUERY_DSP_NAME	1

Why is it necessary for the userspace?

> +
> +/**
> + * struct drm_qda_query - Device information query structure
> + * @query_type: Type of query (input)
> + * @pad: Padding for 64-bit alignment (must be zero)
> + * @dsp_name: Null-terminated name of the DSP (returned when query_type is QDA_QUERY_DSP_NAME)
> + *
> + * This structure is used with DRM_IOCTL_QDA_QUERY to query device attributes
> + * based on @query_type.
> + */
> +struct drm_qda_query {
> +	__u32 query_type;
> +	__u32 pad;

What for? If you have u8 array afterwards, you don't need the padding.

> +	__u8 dsp_name[16];
> +};
> +
> +#if defined(__cplusplus)
> +}
> +#endif
> +
> +#endif /* __QDA_ACCEL_H__ */
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
