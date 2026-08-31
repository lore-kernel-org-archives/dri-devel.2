Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A87BC61DFD
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 20:59:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DBC510E33B;
	Mon, 31 Aug 2026 20:59:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wvr4TpYc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QMjHVEmz";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0010610EAF7
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 20:59:34 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VIXfGY918284
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 20:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5eH2tkoqrxEkiPHG70y7OV/Rv6ro3jsgF0WXE4qtlyo=; b=Wvr4TpYcqqNSNW/c
 7MbI/noBMgaCUGPiX4RNjBSbAAlI6cOG626h8HzDCimzMCq5DR6dyRBuef3EKvWJ
 pmyeItpWbagjmktj0sQR6TmfTyhz4Dz29ufjJuG9MXRO+8V2/zrD4bGQCfC3APBw
 hwOiP1+IW8UwARVGAPJMqbMy2QKLnpPNKMrcQVuTLITjDisdbqmvph7Fm3vAyImW
 e9Vxp5snkUtEuHev9TE+JQA+XS6pKAnAsKEegcI+Hzf/cHJElkii+UrFnGPWRrOh
 gCXzQJj3Zg5Cx7jUdlKC11q5LIuyIRQ7DYidKoga5yvTGmSj/rYaFXi0krGH/xVc
 IKwn2w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdeg38tab-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 20:59:34 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9390a2c895bso875254985a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 13:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788209973; x=1788814773;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5eH2tkoqrxEkiPHG70y7OV/Rv6ro3jsgF0WXE4qtlyo=;
 b=QMjHVEmzllHG9ePlZJkwEtyUGkuj2tv8ltNjxwD5V0oQP9BUUckI9Ewj58fiq2iTwW
 ujcZPRk/tsl31thKuBW1QQE9rsQIdPbeEadQtt5288EaZCFrRBD9qS06NYRHPdad6XIR
 y571glQUWGmwEucdnT3F13vHGz90eY249kMBOxff7/ojFmRYauYgDoixT5ZGeDNzsYRs
 8otHrUwfslkTFbMXNSNf9PDtRMILUHZwvqw235E0sVHS4AWYMQYeCu2KOFHFyQDOnca1
 yiV4rwvSi4wXCasleG7JFnSDE27LZ+JDwaKK9yKUBvPPE0ObsLHhz/Eyz7GFhkqjGAD6
 k2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788209973; x=1788814773;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5eH2tkoqrxEkiPHG70y7OV/Rv6ro3jsgF0WXE4qtlyo=;
 b=d+dJ016ujJuDFNlz7kCwLf+YxiSwgLYIAjg/13tmEAVEoZqLqLw9z4y2oUJA+9CIOI
 ueVAXoM3eGJkfnBy/eyNcerz/aLQTdmKxUaS9kOKqW/ePLn5J4xbCIijc8xjzv1YzCNs
 UTVX/PuwfsXtwtE6cX11AdC4fcn82MCfHJDwo6+62sSyP7G1/SbXQ7amvU2gWouOWbvx
 UQ2FNRUupz30JBI0qxdYjhdXvX0D5Z9/9GuXPvD3kozSP/OHWXwlu5jXshs7T5NUodH/
 HkXpL0HrQ4cYteFPZRtbDyM5li3zryzgHK9UPBWGt3cwyHWJH53DOOaxdYv0yFeUiiLM
 MDpQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqL13DZjbwJj8XPmZORiKrkJ06ODZEjFMBC1DGLJ5pl5TXRdZNF2td3s93V4axSYzwwooyfB5hu+Os=@lists.freedesktop.org
X-Gm-Message-State: AFuF++moKybbImlZ4MBNpfKrrxLpL5Jz++ZAhRJ5M6WGwmfZQiQ1vyzw
 X8vhPv14AxdFpFTTEUYsXiIT7ld4f/gfDvungrRiog/DJFvgas5CI6kjbbV15HRTv8/Rrx7NZ4r
 PN0M6Y/GI1CbPr01oy0ovrv9jM0xe3sv2FbPg1lyJPLRGbjgIFcexMtW6kUDVgerY0Y+YHsY=
X-Gm-Gg: AR+sD13YzSKZOzGr/7V2l7LJn/zt9Rd/b4Qv+lg8YYrPkS+67Sh09ZHpIKJ8eYNh2jT
 eCwwoi0sqQ+3ErfAV84VNY2+9j0R1CUpgsU3UhboXjcIido6sWEY18m/zuFQN3b4d/34wvC7B2O
 aPSU0n6Ji73DKmCtJWCWOuPJ6j0O9s2/5UdI4kxqJFjSS0v6A9Y9c7WUMWDpHMoZnPsEuOtAiS+
 m1z0S3QykzO6C9lSM4Cgnw4UW+e5jqEmkA5+CmFS46+XiPi/nECUI0HEwmARpV/KW9YxMw9i3Y4
 ERlNZLknhK/Cm8DcC+DbwaOYlf5HUe+48qEFuJD16JCudmuvOSSGX1fUrjXTw3NDt0yOfvJBQqu
 dZXbaxYLS2t/9QHX24s30+kQgtex2P+WCMORL5g==
X-Received: by 2002:a05:620a:44d3:b0:937:75cd:4627 with SMTP id
 af79cd13be357-9391395431fmr3175555685a.32.1788209973197; 
 Mon, 31 Aug 2026 13:59:33 -0700 (PDT)
X-Received: by 2002:a05:620a:44d3:b0:937:75cd:4627 with SMTP id
 af79cd13be357-9391395431fmr3175550185a.32.1788209972753; 
 Mon, 31 Aug 2026 13:59:32 -0700 (PDT)
Received: from [192.168.0.183] ([80.233.33.41])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48442d6eafesm277031f8f.24.2026.08.31.13.59.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 13:59:32 -0700 (PDT)
Message-ID: <da6868f1-1f9c-47a2-ac48-88dd160ae3e3@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 21:59:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
Subject: Re: [PATCH 04/10] drm/gem: Convert drm_gem_private_object_init to
 return error code
To: christian.koenig@amd.com
Cc: matthew.brost@intel.com, thomas.hellstrom@linux.intel.com, dakr@kernel.org,
 ecourtney@nvidia.com, nat@pixelcluster.dev,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20260827124910.2245-1-christian.koenig@amd.com>
 <20260827124910.2245-5-christian.koenig@amd.com>
Content-Language: en-US
In-Reply-To: <20260827124910.2245-5-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE4MSBTYWx0ZWRfX/+DQ8zr7lOJ0
 fq1VeZTFJfYzooBnKbHQCg3ckHBNUDn8zflh1WrGLMNFu1BDkaE+zaiP+CdJu3P0AyYwh8uFuwW
 amc+HQ7+eldLWkQ0jNIfyCVBjDCEVYHeAkBOT0ywRIVJ+N0qkUs2sbZGlMeup/omugCiB1Zro6F
 8kT2FZACP4qUWPSFyuI77Hbnhmn7mvE0KAP5zYCUQFZprqWhL+y7npAoKg+6OYa5xEOY1/gtc3w
 BYSMk2sCrHHIjr34zbpjD2y2a8GFgaJ6UJpfxBK/EWbitqcJf41zPF6CKolIvB+XeomNlJS5D/0
 LCfzpHG30JfsMj1OpW85E6S/RFNFCG9RYb4mNP3D5XO6T4UReRV2a8IscG7OxCSAMLMm8a76KJd
 M3x0DeP4Sn203xYsOBj6ck0sZLUWO1lEtkgqNojDPZjeSgRXoGQ6swCrTcVhckIDquqM/Uvwqeb
 bgOZh7BmgdT89PsvnxA==
X-Proofpoint-GUID: 8LRvrj8pcCVhoabCv6Vlbk5CAfb-IjPu
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE4MSBTYWx0ZWRfX7y/Uf0pzpn48
 F7QPHkF3JWixwuRMX7uHiD1b5qaIphH278sbhqC0eE0tAK8j6/XC97OmR7gFifPsOrgfP1d9SND
 0vHwL4mG/ei8MOwY5rJYTjgl6cykoy4=
X-Authority-Analysis: v=2.4 cv=NZnWEWD4 c=1 sm=1 tr=0 ts=6a95eb36 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=le/gl0x2G5+ma5yo0zCuxQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KEyuISjlM5fmf-MbB58A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 8LRvrj8pcCVhoabCv6Vlbk5CAfb-IjPu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310181
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

> diff --git a/drivers/gpu/drm/i915/gvt/dmabuf.c b/drivers/gpu/drm/i915/gvt/dmabuf.c
> index 8a1d6c5636c2..5b198162c588 100644
> --- a/drivers/gpu/drm/i915/gvt/dmabuf.c
> +++ b/drivers/gpu/drm/i915/gvt/dmabuf.c
> @@ -202,13 +202,19 @@ static struct drm_i915_gem_object *vgpu_create_gem(struct drm_device *dev,
>  	static struct lock_class_key lock_class;
>  	struct drm_i915_private *dev_priv = to_i915(dev);
>  	struct drm_i915_gem_object *obj;
> +	int ret;
>  
>  	obj = i915_gem_object_alloc();
>  	if (obj == NULL)
>  		return NULL;
>  
> -	drm_gem_private_object_init(dev, &obj->base,
> +	ret = drm_gem_private_object_init(dev, &obj->base,
>  		roundup(info->size, PAGE_SIZE));
> +	if (ret) {
> +		i915_gem_object_free(obj);
Building on v7.2 with DRM_I915_GVT enabled will result in modpost undefined symbol error.
Exporting i915_gem_object_free() in I915_GVT namespace (drivers/gpu/drm/i915/intel_gvt.c)
should fix it.
> +		return NULL;
> +	}
> +
>  	i915_gem_object_init(obj, &intel_vgpu_gem_ops, &lock_class, 0);
>  	i915_gem_object_set_readonly(obj);
Thanks,
Youssef
