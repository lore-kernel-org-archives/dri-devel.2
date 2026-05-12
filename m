Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5DBCD343F
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 17:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83D7110E299;
	Tue, 12 May 2026 17:09:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="h2PdfjBe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BLRl+K+C";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72B2410E299
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 17:09:11 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CEYZQD1733326
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 17:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WMWRYi8BYzto0LrWIzUiqfuqVp6k7lmRKbzQ04eMDSk=; b=h2PdfjBe9tg/BM/A
 8KK9orsDoK9hWP+UApHZiYFiuu69ax8y8Ct2+Pa3TZOVWhSOpNQCOuljUJZ0AVdp
 r5/fX9jQINrBz/oy8yhJ71pGw/KYEEigWvH7OxMMynslJM7Gi+VxLCQNIHreqwgm
 0aTIhK4ZaRLfRD5ESbSuIm2KBU/6a2j9i8J5wv7V031VHuUGvXlBWA5P7xbWeRyL
 Kb6AbIzhjFobItQ4ZSljRYfmG2U8qzVtJ4UPcrI0FfzxpbueW35WxvlhImhr8YZ3
 x5TPR0rEeWJ7Eq4lNTJgk+J0iHZ7UD4TX5CpCRt0P+lIgoMx1u2Y13Qo+y+o85ip
 kPY+MQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e463dgmsm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 17:09:10 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2ee1da7a13fso7417552eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 10:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778605750; x=1779210550;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WMWRYi8BYzto0LrWIzUiqfuqVp6k7lmRKbzQ04eMDSk=;
 b=BLRl+K+Cmyuet4kZ4xlDREdjnQ5c8RRjdqTuTCyWZBrIAsoNm0uaHSKj9msl1SJ7yJ
 ehbUmPNNpGGMEAwZIP51cg32nriQOuOtGCBmWLueY+6v996n3hj5OetlaZSij4s0/+YW
 Hb1ytJV70BbR/6FvGs8u1uSGz8K/sPNqL1/yqdiuIZ8+jwSKpiCtcTqoNbCBrf+DfEK5
 9cBa5xiZ9ELJWSEVZHBAFW9dPFsZ+1xZpFKDsXjPupx8ZU7VgTfeC/ibvAkieagJxMWI
 12zW7mqjjAZzBOT1tOiRO3PC5Pe+k3ooRavk2O1+SajwFq3yb79iujJK2tlPYao2ZWyu
 AXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778605750; x=1779210550;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WMWRYi8BYzto0LrWIzUiqfuqVp6k7lmRKbzQ04eMDSk=;
 b=DQqitgMgjm0f+voc2ux/F1xViAs8AXV6ucuu2WM5S/HBTNBbNN36TjedwZtlpFh0gN
 GP0Ys9W5UT2x+qFAXUJJV4OtJxP4DMHgFUTNYgQRSBZnPQI4gAQvRd/mPTd9mnjjHlem
 fnmzFNnp2SiQbWGJMlpbugrIO2b9TKhK8yLpco7tyEqbKzbxew8Hu425ULLEpceKFdCt
 gwsbZICpObPiCBOiUWqAOhM5RPYLg56INOo0gWyC03eULWvP0eOROe1UALNOwZ0UNMK+
 owWK1exGVR971uEX7AHoRVGVPVA7aMB+W6dK8pHqnTLBLUvCsg9TKIjN9XEnubbt0HyQ
 5YQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8mcYjI0zUdQ3hYybjjHeURaZj9uaswbT0aw9TGJnNetyxbwZpk44szipPsJSxXMuryr60RgRG3AcU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCcT9WKZQaeNKHmgyYa+h6RaQAGjpGLU6GI6BMdMaelCMBa18p
 aqn7as9M+6JYH1N+Q3q1eCwtRT5wH297slKd8u88s5fXTf9wLA8l8M5iTXyFl+oXFW8XTHGWyvm
 EiDgIi3+EMYx9oSgeJE+hAfFBOwkAzyw0j7I/E/AVhE4TMzX09GOLxdtuScyIFo/DlYpdiI8=
X-Gm-Gg: Acq92OH+WrmwWfP5TMh6VWlfnPM6Zphf2yQRTUv3ESEYcMvUpdLpvoHtc9t5fx4hFkW
 I62jIYqUy8tvD2WXHO27pRE9DIPxPgHcFoIcr435iWwzo8jfn+FRGihoJCkE2gxJRfpJOepoQck
 eFdp/yXWbjlWCeh7x/Aq+/+05Ejv8iwt5rOdUJ8COPEhKQ4W/FCtMXItDWIWSDx+Vc5N3fJsDJ+
 cArWeAX43fuwrAx2msNKZiSdmjJdfAp/31wdfqTHchyMKMfjR3uv29+WHc4LG374R75D8JUy7ti
 X0lzessmMF7Flt5+GgtqqaapoX58UOF3QjPt+vuxHcyy051fCN8Ni7tUsWq3XnYkyJBeqo4fLzT
 BxEUvUbu3q3THZ0IH/g9nbITjDFSZmNHBzUe9sazUXytZZgz26RrTxWXWjNu+CrFO7yed9pBNIe
 A=
X-Received: by 2002:a05:7300:6ca8:b0:2d2:96e8:1bf5 with SMTP id
 5a478bee46e88-2f54d696b08mr15445433eec.3.1778605750207; 
 Tue, 12 May 2026 10:09:10 -0700 (PDT)
X-Received: by 2002:a05:7300:6ca8:b0:2d2:96e8:1bf5 with SMTP id
 5a478bee46e88-2f54d696b08mr15445403eec.3.1778605749553; 
 Tue, 12 May 2026 10:09:09 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8859eafc2sm23409769eec.4.2026.05.12.10.09.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 10:09:09 -0700 (PDT)
Message-ID: <fe4759b2-4123-44c5-a10d-8ad4697f6de5@oss.qualcomm.com>
Date: Tue, 12 May 2026 11:09:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/qaic: Add overflow check to remap_pfn_range
 during mmap
To: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
 youssef.abdulrahman@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, karol.wachowski@linux.intel.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Lukas Maar <lukas.maar@tugraz.at>
References: <20260430193858.1178641-1-zachary.mckevitt@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260430193858.1178641-1-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4c5jfHbilJO5tGqqNzVY2KsUJdR3ENBB
X-Proofpoint-ORIG-GUID: 4c5jfHbilJO5tGqqNzVY2KsUJdR3ENBB
X-Authority-Analysis: v=2.4 cv=aLTAb79m c=1 sm=1 tr=0 ts=6a035eb7 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=ixu4JsPXSrMzd3x0NycA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE3OCBTYWx0ZWRfX6JF7vK76Z/MO
 FlwrHhVVeBFubFzR/bgEZICyepTkC99mG5IIlZHfbLHAnTzsQN0222R7oCL2WL9iYxFDea/o+mM
 GFz4VvLxRq0pgiVHpVRYi64wDBWL+waWYH6Sq+aa6Y2zibqeTknmt1bfPh6zwlMrVk665swYPBa
 Qacq3Yzut/eWAOYEGWAvI6GNremuaU4QjnZEEFKufH09f/AOFKjTtDGxKPhd55ipeucNKJV3QuI
 DUnhETV4Jzmho2aG9TNuHntyzAf0UPKFmPBEN/HDEkKAlLtbTLlJS0GBdS58EGzberAe6hJH+j0
 EcWb3QUAW8XZokctyRIiihu9Loh9+LCP9PlTkoGH/+6TGPBrG61iDOvCglxo3iL5kCXE3cxBRVs
 EI+hTmzpmLWZSpnGf4FeO8yCe7+PglXyflcUpwIATdyAGkNWaOR0Qv1G+d299+LHdHBs1EoFScY
 ig9njE26Pk2pKRG6B1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120178
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

On 4/30/2026 1:39 PM, Zack McKevitt wrote:
> The call to remap_pfn_range in qaic_gem_object_mmap is susceptible to
> (re)mapping beyond the VMA if the BO is too large. This can cause use
> after free issues when munmap() unmaps only the VMA region and not the
> additional mappings. To prevent this, check the remaining size of the
> VMA before remapping and truncate the remapped length if sg->length is
> too large.
> 
> Reported-by: Lukas Maar <lukas.maar@tugraz.at>
> Fixes: ff13be830333 ("accel/qaic: Add datapath")
> Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>

Applied to drm-misc-fixes

-Jeff
