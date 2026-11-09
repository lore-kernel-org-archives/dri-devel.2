Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58184606A334
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 21:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=am+eQczP;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BQ+q2WIA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9055A10E8D2;
	Mon,  9 Nov 2026 21:06:20 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7051110E8CF
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 21:06:09 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HGwjw4125811
 for <dri-devel@lists.freedesktop.org>; Mon, 9 Nov 2026 21:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KehNcAM/I+CG+cC9LNypII+QIVvqswfmnEsbdGljei4=; b=am+eQczPNHV3jVDh
 ZEu3fWVA9aF9sqngd7i1s4DjD84wfrviSPEJ/H4AAnfh+gLGKiWUg90j7udLer/W
 hIe8cP0wTS6Otb1lCqI+GrGDyK3RQAd4pdgTYTLftb31v+F6ORMPTi00wGBsR1fN
 yG7RSCG4hZ7RfTRt082tnrhSi8ouMbVxHbkU22Wbq0OkiF0gYDm9Gv1ZbBVWROfw
 RUK6F876Tm6iRHP48JHkWDJacfoHEqr1a8t57L4vsevK2Q4IYQpj7tjQave+T39V
 ltzQ9Bpz8zSXgp8IAJbIpRhij4F7toVkeXnc5TWkB0zgJK3UvVVpn0HFICF995bd
 kdUb2g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hudcja1eg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 21:06:08 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36efb506f29so2661673eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 13:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794258363; x=1794863163;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KehNcAM/I+CG+cC9LNypII+QIVvqswfmnEsbdGljei4=;
 b=BQ+q2WIA6fxeTqWjksblDbKxYwm5s049i1qJSSxqZlQrnvnrLG0PEPIqAt74mtBWJp
 IrJRlPUu/Y7K9q6vO73zeFwDY18eduHZUCAhN1/o6imUvCmL8TlIdX2PkeVrXg5UOMgp
 UDFsR799hL8BDb+WFGxlxfADNDzoBDxfyF+ynTz2oZSYgI21hZKimSv0iE7nEy9+moPr
 77X18Ygwr5FhJUitmhgDR1hZt2TrlV7cWeaNQAkNHrtZoEJd1CNq4oro6NcrErUATNV2
 1i76QtrGGqMOwJ5gKkjMrgSffuTl0ycoWSIIy2XqoSPALIQLj2+FMaRNnPoofZg7awJN
 hjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794258363; x=1794863163;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KehNcAM/I+CG+cC9LNypII+QIVvqswfmnEsbdGljei4=;
 b=hdgu3EW4g7qDW3iDn5YQrv/fuw1f4M1LfsXNjml81GNuTwxn97rXa1EdRZQf3oogUi
 fkDAGTma5Uw9Ee53ZIKM1cwkzmdfKedCQtK9C0h5guKU+iNvnT30cTZ09yfGg0GLI2lD
 tx/eVCBV0YYWNd5lsLlTz71VcndOrA1rs7wCdsDOR1RaOzWoVPqa4XLZ5P0EnoBThR7h
 dOQCGeP2Ucwm0yoeGIo2k/iP4PMZffatz22ISEKuwdd6pVnS4MZg4ei4BM3C+zYG3yBy
 tfYQyRHY1G0qUu4xliGYcgxQi84RJZKOv9ZKfPAPtMCn7mdRl6vw5+Lbk8F/hE+4PjCJ
 chIQ==
X-Gm-Message-State: APuU4Z82t2Nwz6WVoewsqmlKUWie/JbW+TKSJYH/hIQEuThtuIrKo2Lg
 9po8q31UXjseaKHo2Cg4jGxuuRMQC4tHKFuwDRQ5QDefswL/4xM3dBEK6gGFsIAnha++JHtXzgm
 cJ7ZNiYpKp9JfUJHEjHWPhBJQYSu1Lu8Yuks8iA3/Db26Venjxrat3DmQys5CEcDY8wqLfk8=
X-Gm-Gg: AYBFou2nA469fLDqtrqtDGiLdllw5gG6699xc3FQdCesrqnKUWRXch4mc2yqYZHBE8E
 JCGTBpBX5VhPRnt4xvfsKotNJdLnQwk3YEt9iYnhRTQj5sXSz8bVYxP16WXHk4uGdz31bclq8S9
 27NVz+LGbd0oYA2tsAKb5ZxGXH8CZidCi1MlDp+0GycDIQfw0jDlUaM79uGyPJYrgF2B4oFbHbH
 +C0/3+xndT7f3LCdZkljpVggdNu0kHK0hHbr70LI7fPZBkydttwW66uLlle8gdI+QgYGSJEuU/g
 lQWX002ilRNXG6ZOiDjincjFr+FPANYovxQo/VOPTJo/qAoLPJMDy9Mt8DsRoPJ7NPkXK1GH8l8
 BNKtFg2LPSDTu+CtzDl9OC5wo8BDUHiXI0yDwvdHL4TmHI1pvXouftAr7r6yxzR1ZwNsn4YcSo0
 Am3LRXKnEOAVIIzBRk58jbtW3swLNA5Q==
X-Received: by 2002:a05:693c:41d2:20b0:36b:d3dd:2e9d with SMTP id
 5a478bee46e88-3751f078fd1mr590673eec.19.1794258362967; 
 Mon, 09 Nov 2026 13:06:02 -0800 (PST)
X-Received: by 2002:a05:693c:41d2:20b0:36b:d3dd:2e9d with SMTP id
 5a478bee46e88-3751f078fd1mr590636eec.19.1794258362202; 
 Mon, 09 Nov 2026 13:06:02 -0800 (PST)
Received: from [10.226.48.50] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37520bfb58dsm1484362eec.18.2026.11.09.13.06.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 13:06:01 -0800 (PST)
Message-ID: <152e4fc3-7c74-452c-8391-04d4b0082a4c@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 14:05:59 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] drm/drm_ras: Extend DRM RAS interface to include
 telemetry nodes
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
 raag.jadav@intel.com, simona.vetter@ffwll.ch, airlied@gmail.com,
 kuba@kernel.org, ogabbay@kernel.org, lizhi.hou@amd.com,
 karol.wachowski@linux.intel.com, jeff.hugo@oss.qualcomm.com,
 carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
 youssef.abdulrahman@oss.qualcomm.com
References: <20261106181225.3333260-1-zachary.mckevitt@oss.qualcomm.com>
 <20261106181225.3333260-3-zachary.mckevitt@oss.qualcomm.com>
 <avHpogElibf5F0FR@intel.com>
Content-Language: en-US
From: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
In-Reply-To: <avHpogElibf5F0FR@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yD0i_K-NQYPX2vPMnMeRR3f0Rm0vrIBh
X-Proofpoint-ORIG-GUID: yD0i_K-NQYPX2vPMnMeRR3f0Rm0vrIBh
X-Authority-Analysis: v=2.4 cv=au0nmiZV c=1 sm=1 tr=0 ts=6af235c0 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=xihu62O6HHKiAZ0-3J8A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4NCBTYWx0ZWRfXy360gzAGZkoX
 +bP7Z4k+7kVxB8D9sdzB4BnWeDjYks+OyDibbI3bcTHeVBYLeVOc9Hauo6VFn62MPFzeoKn5uUE
 50M9jKv9n91Z0GO7Is3mJkMRbNEISro=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4NCBTYWx0ZWRfXypFu+QEh/R3I
 WIxFMpy1MaFL3C4amP7DtNCAJAwcJlbFaZnlZMNJPzbHMdoRFIur79cJQwJLnNkbxurU+IXAdQo
 lJorGS/6eIjplvh6brRaU81J7u64k/j8O0IuVBPzSrXbsf4Rfb23zkMwfMUXFaN0Voi1y4MNCUo
 9y/izwVjd5i0y/BHj3v2C21UDsNtgujH/p44X2/jA+kCoC4pI6w9za31wThnMSSOy4Mxxj08Gt/
 w+13EyHmt+Iu8rKQxf89+uEt4G0t6C73fRLzZkx3cdhjvUrywqifk+ro8hAfxObceNpAez9bMbt
 i0KcI9TSpg1vWCF4Utq5JmbOebZAXC2vlUCIFqQajvjFlaRsYenzOFHSNOlGbqHexTC0f+6olEf
 KjwB+a0q3trk/D/tl9vkIBTbSr0jx2TVpli9P/6IS37vAdPcPYVWjaZl/TFV0QDXTbSFkVyrjku
 YuPqDwzhVsNgggSKhDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090084
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/9/2026 8:41 AM, Rodrigo Vivi wrote:
> On Fri, Nov 06, 2026 at 10:12:24AM -0800, Zack McKevitt wrote:
>> Add a new node type, attribute set, and doit/dump functions for
>> performing telemetry read and write operations using the DRM RAS
>> interface.
>>
>> ynl-regen.sh was used to regenerate drm_ras_nl.c, drm_ras_nl.h, and
>> include/uapi/drm/drm_ras.h from the drm_ras.yaml spec.
>>
>> Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
>> Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
>> ---
>>   Documentation/netlink/specs/drm_ras.yaml |  82 +++++-
>>   drivers/gpu/drm/drm_ras.c                | 329 ++++++++++++++++++++++-
>>   drivers/gpu/drm/drm_ras_nl.c             |  53 ++++
>>   drivers/gpu/drm/drm_ras_nl.h             |   9 +
>>   include/drm/drm_ras.h                    |  67 +++++
>>   include/uapi/drm/drm_ras.h               |  19 +-
>>   6 files changed, 545 insertions(+), 14 deletions(-)
>>
>> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
>> index a88fdab7a1c7..cf015bba020d 100644
>> --- a/Documentation/netlink/specs/drm_ras.yaml
>> +++ b/Documentation/netlink/specs/drm_ras.yaml
>> @@ -16,11 +16,11 @@ definitions:
>>       type: enum
>>       name: node-type
>>       value-start: 1
>> -    entries: [error-counter]
>> +    entries: [error-counter, telemetry]
>>       doc: >-
>> -         Type of the node. Currently, only error-counter nodes are
>> -         supported, which expose reliability counters for a hardware/software
>> -         component.
>> +         Type of the node. The error-counter nodes expose reliability counters
>> +         for a hardware/software component, and telemetry nodes expose an
>> +         interface for reading and writing telemetry values to a device.
>>   
>>   attribute-sets:
>>     -
>> @@ -100,6 +100,34 @@ attribute-sets:
>>           name: error-value
>>           type: u32
>>           doc: Current value of the error counter.
>> +  -
>> +    name: telemetry-attrs
>> +    attributes:
>> +      -
>> +        name: node-id
>> +        type: u32
> 
> this we keep for legacy alignment.
> 

Im a little confused at this comment here. Anything you are suggesting 
to change?

[...]

>> +      name: telemetry-set
>> +      doc: >-
>> +           Perform a write of the specified telemetry field.
>> +           Telemetry writes are device specific, and may be used to set
>> +           device limits or other capacities, for example.
>> +      attribute-set: telemetry-attrs
>> +      flags: [admin-perm]
>> +      do:
>> +        pre: drm-ras-nl-pre-telemetry
>> +        request:
>> +          attributes:
>> +            - node-id
>> +            - field
>> +            - value
>> +        reply:
>> +          attributes:
>> +            - status
>> +      dump:
> 
> does dump on set specified telemetry field makes sense?!
> 

The logic here was to separate gettable and settable fields. If you 
check the qaic driver changes in the next patch, you will see that the 
settable list is a significantly smaller subset of the gettable list.

So, the settable dumpit would tell you distinctly which fields are 
writeable. If you prefer, I guess we could add a single dump operation 
with an additional field for R/W, but this will require an additional 
attribute to be defined in the spec.

Any preference?

