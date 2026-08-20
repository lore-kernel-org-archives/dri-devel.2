Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D48C5DF8C
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 04:31:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51C1D10E011;
	Thu, 20 Aug 2026 04:31:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="n2k9h9lD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IqHogLy+";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F6B610E011
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 04:31:02 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JL7jAH1457423
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 04:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 frKQRZUt2a/hKuf4txBejBfHQwTIXAlTZS5704pYNeE=; b=n2k9h9lD8Uzm61+4
 sEva0nvpAsRJWrXOdr+J1+P4jqaOEnkCScuaGIqEAXJvb/EEi6FAH9i2yiYnR5Zo
 krcJFAjEDYTyE4YFPNdttSK7THPJ6XvgM4XBtes0CCr7/7bYb8M9PKd5JtMhq9mt
 zRyxa7CODZTBpr3aQl00AyNix7kM/tSLDfprx6AIKYuzJv9hG8IvfXmv9Nd6yKEB
 S/8Hf2cJHBeZ92D64OkzYGTYyuBWcwWpN8mclw6xRkNohZq9QThOrtqGCE+saDF9
 QvR+hBr2GDFHjTJKtaOgv15GEXffyaVOnyiB7+m1zpWGWGO9mLqKPlUEGa0YOWIp
 WGmMAw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5es4b206-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 04:31:00 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2d52734fc41so37127815ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 21:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787200260; x=1787805060;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=frKQRZUt2a/hKuf4txBejBfHQwTIXAlTZS5704pYNeE=;
 b=IqHogLy+LNa1X7O7gzhdvxrM7714BZOHj3AMsHViMzU1jdWmCaCkZ4CfytizxwS6Su
 51kIJNAgz8OxhtIPuej0HC/YMoBTe8gkO5zHbSJogUln7ivWoGp/EtzUO98Rsx5tSXWZ
 uz9sg+jy2f9QKyn7puzSezW9QxTB37BI72AtglX16tNIR3VTcDQA9jeGfcSLySdOJFNf
 9MeXKGBHQI5tq8x5Gr+tWRlrBNGILoWS2kHRKECpybqB3rvuszQOFO91FMseTJYaQQDZ
 OvBxtNuXL9xHURr0oQbjYYWzkipO1JDq2BGILZuhSZGlUZO5Ey0NseVjhUrtia8S2ecy
 yzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787200260; x=1787805060;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=frKQRZUt2a/hKuf4txBejBfHQwTIXAlTZS5704pYNeE=;
 b=OJ84s+rb7MMRaB4kOoZFVwnK+iP1pEEHgnFwHE5kDIYgAKLW4fxy+BIT1X1Ca39oKx
 kWelkYDcVNUcWMGO95OmIQdmRA5m/0TtYbGr0lU16EL0/UiMf48ELZ9CYj17F+6bhV8T
 7TkY5MevHNwkKOnY26mRnuYHC2XH+zMTpT4mN6TmdkFTSiKRn2ooS1mDt99LGxYatf+w
 6YVLFgEOc18wVcjBxaupk521kDUBAyu6OcoJTM3dhcJ83z8+ruAHNihyitAb5GgXYL2o
 cfQyrqjRut40huIrTAG10LEharbneswK+z6tp2uQJ9xZys8piphBIvjVgBjPpEBQoeYJ
 fKNA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrV+70xRsPH5EpZkqXp05ZE+jFfUdFdZD7YjBBmuYRP+IRItwXP4X2JH2lm+Pnk1Oy5WajggYAARIw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nMeCqM6/jSBGL29Z0GKb08lAxrYY/Aq41i5tfbB8G40VAOUMfA
 RI2p7ULiwFh0w2j3ONzr48L+rxPst4kXJX8Jf9l3mbWpmrkaQh2INYy3Wj+/5p+3EeTxFpfFGwt
 G20i/6MDC642WcJiuXQTZyvH+jxFwpwYTICTIaSVNSPbmWx+EAJ3lYuiHe1bofbH/NAZ1bSA=
X-Gm-Gg: AR+sD13Flhk4I6rsZPDMVMkg8nu0h2AqDqKmMzn8xSWG3g3hX9Jkk7hmj9qYKHeTJC3
 xJosTD8R5hcRXcd9CG/W+O9wJ//jgkqi6jFt81r2mPiQDgxXOb+/IwLFf2NdK4XCPC9HV/rj3Du
 /EhIoOZO6/WrUQ9tDcTxlmrNf5F7HoAE+4eRwagQsBbZa9yePb6c6iaUdD+I4Ka4VXYR+TbCDZl
 +hS5jWKY+fHFMlSBJGpYqLLDbNxYiFXhRJ4r0408bKKFKC0lGgeaoBXwszbMRjVdj+CULuOd7jY
 ylCeCI9XtUJHHl2uyslXTZfhvydVwTLxzjA2oDiJ9Vs+GJehfz+bHZh4ABUU3kGx932AH0bR6/T
 gGmYmpJCzcju/G/VmeTwY843u8e7JUA==
X-Received: by 2002:a17:902:fd8f:b0:2c9:df1b:e948 with SMTP id
 d9443c01a7336-2d5fd5cee10mr198915465ad.4.1787200259830; 
 Wed, 19 Aug 2026 21:30:59 -0700 (PDT)
X-Received: by 2002:a17:902:fd8f:b0:2c9:df1b:e948 with SMTP id
 d9443c01a7336-2d5fd5cee10mr198914735ad.4.1787200259383; 
 Wed, 19 Aug 2026 21:30:59 -0700 (PDT)
Received: from [10.219.56.166] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d62d58a897sm1806855ad.27.2026.08.19.21.30.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 21:30:58 -0700 (PDT)
Message-ID: <7e025cc8-bdd8-4247-923d-821089a8457c@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 10:00:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] misc: fastrpc: avoid duplicate DMA mappings in
 fastrpc_create_maps()
To: Jianping Li <jianping.li@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Ling Xu <quic_lxu5@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, quic_chennak@quicinc.com, stable@kernel.org
References: <20260805060940.41414-1-jianping.li@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260805060940.41414-1-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2-RJwqOuuPpB7vctnefrZb0tH90Ls1vP
X-Authority-Analysis: v=2.4 cv=PZXPQChd c=1 sm=1 tr=0 ts=6a868304 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=CeeczvWzjZu7FbgsozkA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDAyOSBTYWx0ZWRfX4IsfMcvNIa+Y
 ztKH+JnkIb+DxDvVKaZeFPsE3+c3GcwLTjqP7FNrBuRV5P1OrxdPsqXpnADQp/fsxNVfg4lGmVG
 IZzpp4ANOYkliN5sg1FMpEC8ornkzkU=
X-Proofpoint-GUID: 2-RJwqOuuPpB7vctnefrZb0tH90Ls1vP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDAyOSBTYWx0ZWRfXx6561lPaBdrI
 MTQp/BNcoz9E5WX/vx8NZZcGT1nrlwTA6qVfJRGGCQXfQFGnFfaqqiy2GywXgIUEBha8mgQGK9n
 IOs8ROy/Z23kLz55bJTXet6YSkHF1js1wEs1WhXniR2fD5rrfBNXZCA8A8ESLFMZASg6rDHvEKM
 D4BjDWI6+dK0SOqok6kBjMxVgnzwl9oUgTMZidRtryMoDjAH/vEzXy8uDWzuElY3psbfWb/iIaM
 Zj88oxSta35ugFRrUnK9ZJ00PO679F/uKa902mGO8EYM/e29O68ZA0LfRnv7pnqV+PxByvlimAr
 epEojbn33YrWkPJwoMA75wCGXb3zbGbt09Yk89Tbq4MjOACH9VMz5Gy+IpoIsEm6jY2aveMeV5d
 cA6kBmKDYIseBrlLh7Oask9QH9PGON2Krxq8x2/UUuBdPqoVHCDpkzC9Gd4cRWreHzuEvRA5NFz
 mciXi+hwIdOao2kH4qg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200029
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

On 05-08-2026 11:39, Jianping Li wrote:
> DMA handles passed as invoke arguments (scalars beyond nbufs) may refer
> to the same dma_buf fd as an input/output buffer argument. Taking an
> extra reference for such DMA handle maps leads to duplicate mappings and
> an unbalanced reference count, since DMA handle maps are released
> separately when the DSP returns the fd through the fdlist.
> 
> Fix this by not taking an extra reference for DMA handle arguments
> (take_ref = false) and tagging them with FASTRPC_MAP_DMA_HANDLE. As
> these maps are borrowed references, fastrpc_get_args() re-validates the
> map via fastrpc_map_lookup() before dereferencing it, so it is not used
> after being freed. fastrpc_put_args() only releases maps flagged as
> FASTRPC_MAP_DMA_HANDLE and clears the flag to guarantee the map is freed
> exactly once.
> 
> Also reject FASTRPC_MAP_DMA_HANDLE in fastrpc_req_mem_map(), since such
> handles are already mapped implicitly during the remote invoke call and
> must not be mapped again through the explicit MEM_MAP path.
> 
> Fixes: 10df039834f84 ("misc: fastrpc: Skip reference for DMA handles")
> Cc: stable@kernel.org
> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>

Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
