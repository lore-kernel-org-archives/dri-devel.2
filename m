Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603A5CCF2DA
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 07:22:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAA0410E3F5;
	Mon, 19 Oct 2026 07:22:08 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7456F10E3F5
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 07:21:56 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J4jGsX1555639
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 07:21:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RW04UJAChk1zLpmtFuvB+VwxtXHR+RDaCh3ieWKs66o=; b=HoGjtrxnPrkHoHgz
 Y7Hz0FVLU0lVIHg5+7tYaPGEM8xZcVuVdv9K7zWOLO2Ki4AEWgFEyYEImDYFfwu5
 WGzIcPwu5bOXFlzvggYKxxGQpQJxkKwD74iy0b+RT6wnyQY5Xwjfscznubqt4CEw
 0RcuOpT70kDVB83QbkB4NdhMlNtXQaaQMjb2PYwRMAl8VA+BK/SsQmPAB29Ki2jb
 GiJx8wKdAz/kSwy7RKxpy3DDQPVZPwGP7gIffUJN6NgslHReBasW9yQTqdYNPF/2
 Qs1+i69qv23SL/D4erXrY/VgerHSfO3rvscKu71nuUDm94qQNiM1vB7dDNqMhIP5
 MFhCtw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hd5ur1hta-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 07:21:55 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33713e5e6daso2654507eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 00:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792394515; x=1792999315;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RW04UJAChk1zLpmtFuvB+VwxtXHR+RDaCh3ieWKs66o=;
 b=c+L36lulHja6yMOFFZToT4YY39vHI2iuBTgTc4wSRgTCniXEwXCpBGw6apnaAqU2aR
 p3e8r/4cFIvgqAEjNPt2Gi0Daoxgvt/KkLICvoIlpzkKFLsc7d6X4k3575IkIBKqqdnP
 YV/7m0xmHW91pe/PrEBIHMY0lAhEBUS7Gvb3ioYEXLQBM8rSWFECuv72hP8uuOB2e4KF
 Jwnp4eiC3ozK078ytiArSP27qmvCpSQTu3koPq+M3DVXwIdE8Vkk8AP9IMUxb9ZSk0mj
 R8TpMuMKWKMp/RwxDE7F8lNZkNJzlKNairVfZ9K1L2q6CXwBv9rjgRUvjYBcH5fuNHpB
 j01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792394515; x=1792999315;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RW04UJAChk1zLpmtFuvB+VwxtXHR+RDaCh3ieWKs66o=;
 b=jd2deb0XSTbxZTCB/lzH3lg7mwpneV2zuJ1DItWvw+kUp3xiG4RwV2lfP2KpFRTBDr
 PBabNkyW31Ro1Gb8IabwtCXxrDRtL/XhSX6iTKdwMO35YejRD67tEQsNArYa0lLyCoMv
 N+nMucxApy/TzM6+rfaNCqHHGsvvmJULVb/KAs/S7cTXzvXG/tSB3lhIcVtsLbrCQitO
 GXjd6WSu6jwNVACgkEz3E4pM+Of21KLMVpx3Xhx1Z7uLkKxzSL3OUEeavvzyfpXsqStA
 ij4Si/n514KmJV7gBYq2L4UYnlH6n0v6qFzp+GPcK9DO/wO8aYEhoTuMYNUwoR+jEt81
 IhoQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxwdKxeqzZO4GGLYAtfddRmpPVTnu1Vk+py++URP0fJYz7CUsMWVJhObCUCvOI0lARnG2qZ1HRySc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJRHWhM1Z7ElEC5Euy+TVFjSWl78VfeZWeQDe2jU0XOLrrjmJIg
 jDWIbvdFYmtAaR0jmxNPAqsirSWyaOaPWxkcziHFnlpQP11fHEGtEuMgA3ehJMh78Dus/YNuP6D
 cfxM6EE/db+AZIZ9oHVuLVuiEVURvlNoai8bkMFXoV6tyXkelsLBRvC+n0RiCfX3adnNXaVQ=
X-Gm-Gg: AYBFou2D0Mfn9IEoGdhR5hXjjG0XbkbNSXW1Uz9X4l1X6L4nxrbQIdPJ1Po9cx900lI
 j0WNh2zRaLp2r2RoagcPbF89iZZMPuhWZ8PcFhHVSCbJRHb1HX4wgulRa3y65JQjF4Q4TeouCo+
 BbXDDSz2m4bQxqR09n2p3BhHBygq7JZEKHMWOam7PyeA5JLStgS/xvGZlWXYuIQdYHSJ+3RbVdH
 iopORGADH/+uFacY03dHyowKc3vmYsOkx1hpLEtZF7LiS4ClsVw6Qw1E1X/5u29X8bspUbXrd35
 zinJ0jI9ZZuKVR+mNOHggkS0dWslMcYtisJtZgLLUX3CeaMx7HURlcUzARLoeviZmUB2D5JiBGK
 6tjSwSasysiQQ/z/NuOsXGImS
X-Received: by 2002:a05:7300:ae22:b0:356:9345:a07c with SMTP id
 5a478bee46e88-361a1b52d40mr10457794eec.22.1792394514783; 
 Mon, 19 Oct 2026 00:21:54 -0700 (PDT)
X-Received: by 2002:a05:7300:ae22:b0:356:9345:a07c with SMTP id
 5a478bee46e88-361a1b52d40mr10457763eec.22.1792394514172; 
 Mon, 19 Oct 2026 00:21:54 -0700 (PDT)
Received: from [192.168.1.7] ([101.0.62.42]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm49639768eec.28.2026.10.19.00.21.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 00:21:53 -0700 (PDT)
Message-ID: <2e1f73f2-5ac5-42f0-abfd-93d428528e40@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 12:51:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] misc: fastrpc: initialise channel refcount before
 exposing the misc device
To: Jianping Li <jianping.li@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Escande <thierry.escande@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com
References: <20261007084447.922-1-jianping.li@oss.qualcomm.com>
 <20261007084447.922-2-jianping.li@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20261007084447.922-2-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAyOSBTYWx0ZWRfX/PKpsJHQsQPQ
 0+ndUwWlr0Vs11mzJ2N1Simhr9S3k7nMf+2RDKIFUvbirpSraUmSgmV56UJHHVRzEE9Ktb3B1gR
 dpWGpAYyDVklKtj3PqY3cttxz3zeGHc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAyOSBTYWx0ZWRfX6+7s4JbULp2B
 dhgqhxAN9n2pKchqjp1qdUDKcnZzLaucXK+MLPbVPGZ8yXNPMOnk+FJ9KX/thVt71oPbNXGUbnu
 Ovp2GzEDmITvoJyLVs8KfpFIapYliPdkHjY603r26x/xNUalQ5wUZZkiYuqsQSPTdzcLYhyTmG9
 jNKIxB8Z4vj4p9P5a8+4GRZqGu9hSisTuC684M56KrPeYJ2beFw1t/rHz+M9Kk3cM0kzdONaiLx
 MRzYgMHtJ+rd9FeWBACeX5iF12V5wB/EKKJ6ZPwjOw9n1+LkVlMhdxoD9APAZLPFi1lF0gt0lbA
 apNtlUSOWnLMLhOUkux5sG+QC92WWiq+XhMa6S0xJKTxz2zpFWPBdONXkeiT1y9Vy7jyZbHReBW
 JiQtP3ZCcmJv50o8SKQit5kT2f8cNFtNvtM053etpCvmKQ4BOiAdnw0pA+/zCfWANP9JXD5zR/9
 OX9TESW+sp1H9S8mM3Q==
X-Proofpoint-ORIG-GUID: xS5JCjaaavi2pS6-y3dVhPe4sb66w9wz
X-Proofpoint-GUID: xS5JCjaaavi2pS6-y3dVhPe4sb66w9wz
X-Authority-Analysis: v=2.4 cv=CP6/zhrD c=1 sm=1 tr=0 ts=6ad5c513 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=sC8K8RXUWm68HHFV/PXcoQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rhkbLGPNnmkQcCxMrrAA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190029
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

On 07-10-2026 14:14, Jianping Li wrote:
> fastrpc_device_register() calls misc_register(), which immediately makes
> /dev/fastrpc-<domain> visible to userspace. However, kref_init() on the
> channel context refcount only runs after the whole domain switch()
> completes, several statements later.
> 
> Any process that opens the device in that window reaches
> fastrpc_device_open() -> fastrpc_channel_ctx_get() -> kref_get() on a
> refcount that has never been initialised and is still zero, which
> refcount_t correctly reports as a use-after-free:
> 
>   refcount_t: addition on 0; use-after-free.
>   WARNING: CPU: 0 PID: 760 at lib/refcount.c:25 refcount_warn_saturate+0x120/0x144
>   CPU: 0 UID: 0 PID: 760 Comm: adsprpcd
>   Call trace:
>     refcount_warn_saturate
>     fastrpc_device_open [fastrpc]
>     misc_open
>     chrdev_open
>     do_dentry_open
>     vfs_open
>     path_openat
>     do_filp_open
>     do_sys_openat2
>     __arm64_sys_openat
> 
> This is easy to hit after a subsystem restart, when the DSP daemon
> reopens the device as soon as it observes the PD coming back up, racing
> with fastrpc_rpmsg_probe() on the rebind path.
> 
> Move kref_init() ahead of the device registration so the refcount is
> always valid by the time the node is reachable from userspace.
> 
> Fixes: f6f9279f2bf0 ("misc: fastrpc: Add Qualcomm fastrpc basic driver model")
> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index af18ff1992ee..05b2e7e4ad3b 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2599,6 +2599,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  	data->poll_mode_supported = soc_data->poll_mode_supported ||
>  		of_machine_get_match(fastrpc_poll_supported_machines);
>  
> +	kref_init(&data->refcount);
Need to move all initialization before fastrpc_device_register(), this
is already being handled by this patch[1].

[1]
https://lore.kernel.org/all/20261001-fastrpc-probe-fixes-v1-2-1376d93b8b3e@oss.qualcomm.com/>
 	switch (domain_id) {
>  	case ADSP_DOMAIN_ID:
>  	case MDSP_DOMAIN_ID:
> @@ -2626,7 +2627,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  		goto err_free_data;
>  	}
>  
> -	kref_init(&data->refcount);
>  	atomic_set(&data->ctx_seq, 0);
>  
>  	rdev->dma_mask = &data->dma_mask;

