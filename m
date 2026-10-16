Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59938CCF2C3
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 20:09:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFBE110E183;
	Fri, 16 Oct 2026 20:09:31 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD18B1129BE
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 20:09:20 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GJe93X031821
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 20:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6kYxzNclKEel8BkYYMK0SJ40K5Fwar4dQSxuwGkd2oM=; b=okS0H1mWOwsIqNwO
 Qp7LX0zL3c2SRgJIxWcmHrTbe7VtOfCNHbmWHEjJ2QBxW/WIan8+JYfF+2kyjy/w
 abJzpHSXTt8RV1xI+8J2KBtuY3qgkf9HBU/8vsJuMF3cp1tcsBhHxtF1q7zesJwJ
 Qgt3jPzKNXcKbIezNF4oqeJS09SCWbZeWGMH4D1TdkU4GQ4I+i/Z7XGlvEpJNDND
 UHCabCobpPUVLBr1IhJLCixdmESkwjM8jE7MAH3jmxkmd/itQzODR6qqJh8vV+uu
 oIQ5aSXWQLOkPF5Lw5tdhPU6+k0l2w3THA9+rzPtYZxxaO9c5p0AFNhkMHy1GB8v
 g4amCw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbrvwgd06-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 20:09:20 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-351788121cfso811855eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 13:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792181359; x=1792786159;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6kYxzNclKEel8BkYYMK0SJ40K5Fwar4dQSxuwGkd2oM=;
 b=SnLBysyezlWg4zTfAKgAyQR+/mMCR8XMCEO/FaZPAAWXr+yB1FTE9ttZZRrk6gTfR6
 I8vAb29V6IKrORtChTqzKox3FPDls19wtLt8D0QLd9+lTRQQy+wxrbi3GXmu+337T6AJ
 +YaOu8DwJuxPx2RGzmoNU/FwEyDaZJ606CL4703U0VtnKIiGr6lSGG5AqJW/Ao2dYTGG
 fQlakszLzFL64UaGi+RMbvQmWT22oqusry8cYAYhTnVmp/q2umfalW4wCd170MtbZrlA
 Q1KnG6i1XANAxTZpw1UKh9oi+OkV8NolqCe3FJ+ze87OU2HDZspDCdXWhmTbnhCxCB+I
 ycQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792181359; x=1792786159;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6kYxzNclKEel8BkYYMK0SJ40K5Fwar4dQSxuwGkd2oM=;
 b=lxx700473c5vk6wu0t2tefvLGOxs0BnF1Tn74TKJcFHoMs+2BNhjq76YNmnHHWGD0/
 P5vp8l4/vn2H5UqU4bgFmMCP2TtN4s/+kDg4UB8V4Z4kLOR7Z3i3LzOoVckApebIJRF4
 el3GU3HNDJL3xvW5HVIs4vz6kJwgFskohyFM+tqNuxVCliYYa3LrhmjtqvOSup/S2ExY
 WHYaMsyMbZ0TJmUb+/L5ThQ1xzWA+j/g3D2d6bJ9qYjc0SVlM+je12lNDcLh/KgjoBEP
 +ObL2Pes0CfAt6dRy7XYYbLeXJqbohwn2DY8j3CilZcxlf/s0jaxxnNVvdmuZegVG2Sv
 R5WQ==
X-Gm-Message-State: AFq9FYKAqq+b5xQZzhIJmE8B5ZJmKJu9/UTpN71EkX72tw780h3ufo5U
 2EeymePwiD3wLp0DtDrju74KMfQsvxMDNrB9dtkX9assHRKCaZDCyi/wenYr6ERiv+lZiMztQPN
 Sqcat7EvcONjkBXcpxXjeh+SelMWanFBpAux+RB++IZqIXtk+B9bu0CfD9O5aasmnDqXEZqw=
X-Gm-Gg: AYBFou1kVgVyYNoJsmdX1esablyJanfjLiHZw7fXXADERixpSJ0hZCxu5upbHmbWSlR
 UWlQFLyzmFf/rUGCs4h3zz+uskpRhslWvY/+nVHoy9f+SLbVn2+oei8VfWIcR8NUqKQhwPVh93V
 tsVfMK1Ct0R7VPX02KuSMPeOpHNpk9lo1IN8tnHcsslnXqVtEx/a6OUad0JQzQa8KHjmiHhuUBP
 HO8jmuB6JfhC3tuCRmrWGW+9d0+eTeks3mKLNECddmCd9CFtAs0IWKHvBSytVNIqvB7A5Mf5JbJ
 x35UU4YOaq6YbvU9NKxw47nBIfQt3utQ2GqQ2Vc3BTy15AnbhEJI8h1oJ78Gjl8rrWUunCdV/Av
 LWEq7kCXkTyIgD1E27C4gU87dBLfARdTLbeEZQge4eLm8eeJRfcC6F+MH1A==
X-Received: by 2002:a05:7301:1702:b0:35b:bb89:231e with SMTP id
 5a478bee46e88-361a253ea33mr1057891eec.29.1792181359050; 
 Fri, 16 Oct 2026 13:09:19 -0700 (PDT)
X-Received: by 2002:a05:7301:1702:b0:35b:bb89:231e with SMTP id
 5a478bee46e88-361a253ea33mr1057828eec.29.1792181358121; 
 Fri, 16 Oct 2026 13:09:18 -0700 (PDT)
Received: from [10.226.48.50] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3607ee0cab0sm11053337eec.3.2026.10.16.13.09.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 13:09:17 -0700 (PDT)
Message-ID: <5869b931-4c5b-47a1-a81e-13123165e86f@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 14:09:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/drm_ras: Extend DRM RAS interface to include
 telemetry nodes
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
 raag.jadav@intel.com, simona.vetter@ffwll.ch, airlied@gmail.com,
 kuba@kernel.org, ogabbay@kernel.org, lizhi.hou@amd.com,
 karol.wachowski@linux.intel.com, jeff.hugo@oss.qualcomm.com,
 carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
 youssef.abdulrahman@oss.qualcomm.com
References: <20261009173152.2436195-1-zachary.mckevitt@oss.qualcomm.com>
 <20261009173152.2436195-3-zachary.mckevitt@oss.qualcomm.com>
 <as_v6iB__bh3cHm3@intel.com>
Content-Language: en-US
From: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
In-Reply-To: <as_v6iB__bh3cHm3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: AOaLmqzFR-UB6TcRydpk8pcIF_fY0HL9
X-Authority-Analysis: v=2.4 cv=COa/zhrD c=1 sm=1 tr=0 ts=6ad28470 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=tArK308TId--5egZv2cA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: AOaLmqzFR-UB6TcRydpk8pcIF_fY0HL9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA4MCBTYWx0ZWRfX90vPDkzChEZi
 PDZMp5XTPutqBZuwSEO28XbkazaiLJSU7rp9v/+A6AO8cS274h8b/4mhNEeAqz5D7YxBy3ew1FA
 BwFez1kG4WGWDMb+xplrR73VL3bYWJdYKM6uDQrgTYgF2Y9o9pEoJ2r893i254/p1ZRlYJa1arK
 a0ydidAOcGNES+YBqQO6dBmBqGbt85g8aR9BiBGd49KuhFzFqY82sn3j1I94Nz+j3cwF7XWOOVU
 dnLBlTVgV+9qX1W2WRlZ5vbYRvDlNdrtnfk2OtQI2Rc1GDj3ixgCsxVJo+/znIHJ1LI3REgAS2D
 BSQw9K3yJvXRdhmRMmyWMNWbGd2BCn4vXUK8NyVPZuRG8uKVBOKxVtvxQWqU6R6eQOmemFsWx7I
 5s/VAFH8uYqFx3mD9HuqSFHN3JP7OcFJRyZY3gdR+bHj3FPRWjgVvdAk6izW8sc+vDAR3Yn1GVJ
 XDrq3NLObWdckzTWedA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA4MCBTYWx0ZWRfX2RL8OHWVSSkT
 7y7PgQh4Y47uNBvn0d8nkKVmeu6I++FfJz1Md6yO1KP0ASgJTU65FSg23ACOC9Y3ow+Tl8sHWxM
 f28BMCPg8bc9CsxWAHsXMa340TvzN5A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160080
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



On 10/14/2026 3:11 PM, Rodrigo Vivi wrote:
> On Fri, Oct 09, 2026 at 10:31:51AM -0700, Zack McKevitt wrote:
>> Add a new node type, attribute set, and doit function for performing
>> telemetry read and write operations using the DRM RAS interface.
> 
> Hi Zack,
> 
> I'm glad to see more users of drm-ras and glad that the flexibility is paying of
> 
>>
>> Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
>> ---
>>   Documentation/netlink/specs/drm_ras.yaml |  55 ++++++-
>>   drivers/gpu/drm/drm_ras.c                | 193 ++++++++++++++++++++++-
>>   drivers/gpu/drm/drm_ras_nl.c             |  29 ++++
>>   drivers/gpu/drm/drm_ras_nl.h             |   6 +
>>   include/drm/drm_ras.h                    |  39 +++++
>>   include/uapi/drm/drm_ras.h               |  14 ++
> 
> just to confirm, you used ynl to generate these most of these files right?
> Please make sure to mention in the commit message so we are sure.
> 

Correct, ill add a note in the commit in the v2.

>>   6 files changed, 327 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
>> index a88fdab7a1c7..d558eb1cba3f 100644
>> --- a/Documentation/netlink/specs/drm_ras.yaml
>> +++ b/Documentation/netlink/specs/drm_ras.yaml
>> @@ -16,7 +16,7 @@ definitions:
>>       type: enum
>>       name: node-type
>>       value-start: 1
>> -    entries: [error-counter]
>> +    entries: [error-counter, telemetry]
>>       doc: >-
>>            Type of the node. Currently, only error-counter nodes are
> 
> Please ensure that the doc is also updated.
> 

Will do.

>>            supported, which expose reliability counters for a hardware/software
>> @@ -100,6 +100,31 @@ attribute-sets:
>>           name: error-value
>>           type: u32
>>           doc: Current value of the error counter.
>> +  -
>> +    name: telemetry-attrs
>> +    attributes:
>> +      -
>> +        name: node-id
>> +        type: u32
>> +        doc: >-
>> +             Unique identifier for the node.
>> +             Assigned dynamically by the DRM RAS core upon registration.
>> +      -
>> +        name: field
>> +        type: u32
>> +        doc:  Telemetry field to be read/written, e.g., SoC temp.
>> +      -
>> +        name: value
>> +        type: u64
>> +        doc: Value of telemetry field that was read/written.
>> +      -
>> +        name: status
>> +        type: s32
>> +        doc: Status of the telemetry operation.
> 
> is this status the hardware itself that is giving?
> Please add some doc around it to help us understand the need and see if
> is generic enough and mandatory vs optional.
> 

Yes, it is a hardware status. I will add a more in depth doc for this in 
the next iteration.

>> +      -
>> +        name: pad
>> +        type: pad
>> +        doc: Alignment padding used for 64-bit
>>   
>>   operations:
>>     list:
>> @@ -198,6 +223,34 @@ operations:
>>               - node-id
>>               - error-id
>>               - error-threshold
>> +    -
>> +      name: telemetry-read
> 
> should we do get_/set_ instead of read/write to align with the existing
> entries?!
> 

Sure, will do.

>> +      doc: Perform a read of the specified telemetry field.
>> +      attribute-set: telemetry-attrs
>> +      do:
>> +        pre: drm-ras-nl-pre-telemetry
>> +        request:
>> +          attributes:
>> +            - node-id
>> +            - field
> 
> how do users know what field to read?
> Why not a dump or at least a dump field for field discovery?
> 

We define the set of fields for our devices in our uapi file 
qaic_accel.h, but I think a dump is probably a good idea here.

>> +        reply:
>> +          attributes:
>> +            - value
>> +            - status
>> +    -
>> +      name: telemetry-write
>> +      doc: Perform a write of the specified telemetry field.
> 
> what is a write telemetry operation?

Our device has certain fields that are writable, e.g., 
QAIC_DEVINFO_THERMAL_WARNING_TEMP where the host is able to modify the 
device's thermal warning temperature threshold. These make up a small 
subset of telemetry fields.

> can we make this optional?
> 

Sure, I will make it optional in the v2.

> even write is allowed without admin cap?
> 

It seems like all of our existing writable telemetry fields should be 
restricted to admin cap only, so I will add the admin cap back in for this.

>> +      attribute-set: telemetry-attrs
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
>>   
>>   mcast-groups:
>>     list:
>> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
>> index b099eb67836e..b88293295cda 100644
>> --- a/drivers/gpu/drm/drm_ras.c
>> +++ b/drivers/gpu/drm/drm_ras.c
>> @@ -53,6 +53,15 @@
>>    * 7. SET_ERROR_THRESHOLD: Set error threshold of a given counter.
>>    *    Userspace must provide Node ID, Error ID and threshold to be set.
>>    *
>> + * 8. TELEMETRY_READ: Read a telemetry value.
>> + *    Userspace must provide Node ID and telemetry field to be read.
>> + *    Returns the status of the read and the value read (if valid).
>> + *
>> + * 9. TELEMETRY_WRITE: Write a telemetry value.
>> + *    Userspace must provide Node ID, the telemetry field to write, and the value
>> + *    to be written.
>> + *    Returns the status of the write.
>> + *
>>    * Node registration:
>>    *
>>    * - drm_ras_node_register(): Registers a new node and assigns
>> @@ -63,7 +72,6 @@
>>    * Node type:
>>    *
>>    * - ERROR_COUNTER:
>> - *     + Currently, only error counters are supported.
>>    *     + The driver must implement the query_error_counter() callback to provide
>>    *       the name and the value of the error counter.
>>    *     + The driver must provide a error_counter_range.last value informing the
>> @@ -81,6 +89,12 @@
>>    *       that are raised by the hardware.
>>    *     + The driver is responsible for error threshold bounds checking.
>>    *
>> + * - TELEMETRY:
>> + *     + The driver must implement the telemetry_read() and telemetry_write()
>> + *       callbacks.
>> + *     + The driver can optionally provide a pre_doit callback, telemetry_pre(),
>> + *       to enforce permissions checks on telemetry operations.
>> + *
>>    * Netlink handlers:
>>    *
>>    * - drm_ras_nl_list_nodes_dumpit(): Implements the LIST_NODES
>> @@ -95,6 +109,12 @@
>>    *   operation, fetching the error threshold of a specific counter.
>>    * - drm_ras_nl_set_error_threshold_doit(): Implements the SET_ERROR_THRESHOLD doit
>>    *   operation, setting the error threshold of a specific counter.
>> + * - drm_ras_nl_pre_telemetry(): Implements the TELEMETRY_READ and TELEMETRY_WRITE
>> + *   pre_doit operation, returning 0 if valid.
>> + * - drm_ras_nl_telemetry_read_doit(): Implements the TELEMETRY_READ doit operation,
>> + *   invoking the driver's telemetry_read callback and returning the results.
>> + * - drm_ras_nl_telemetry_write_doit(): Implements the TELEMETRY_WRITE doit operation,
>> + *   invoking the driver's telemetry_write callback and returning the results.
>>    */
>>   
>>   static DEFINE_XARRAY_ALLOC(drm_ras_xa);
>> @@ -617,6 +637,156 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
>>   	return set_node_error_threshold(node_id, error_id, threshold);
>>   }
>>   
>> +/**
>> + * drm_ras_nl_pre_telemetry - Enforce permission checks
>> + * @ops: Generic netlink operations
>> + * @skb: Netlink message buffer
>> + * @info: Generic Netlink info containing attributes of the request
>> + *
>> + * Enforces a telemetry node's pre_doit conditions (if they exist).
>> + *
>> + * Returns 0 if no pre_doit is specified, otherwise returns the pre_doit.
>> + */
>> +int drm_ras_nl_pre_telemetry(const struct genl_split_ops *ops, struct sk_buff *skb,
>> +			     struct genl_info *info)
>> +{
>> +	struct drm_ras_node *node;
>> +	u32 node_id;
>> +
>> +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
>> +	node = xa_load(&drm_ras_xa, node_id);
>> +
>> +	if (node->telemetry_pre)
>> +		return node->telemetry_pre(node);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * drm_ras_nl_telemetry_read_doit() - Query a telemetry value
>> + * @skb: Netlink message buffer
>> + * @info: Generic Netlink info containing attributes of the request
>> + *
>> + * Extracts the telemetry field from the netlink attributes and
>> + * reads that value from the device.
>> + *
>> + * Return: 0 on success, or negative errno on failure.
>> + */
>> +int drm_ras_nl_telemetry_read_doit(struct sk_buff *skb, struct genl_info *info)
>> +{
>> +	struct drm_ras_node *node;
>> +	struct sk_buff *msg;
>> +	struct nlattr *hdr;
>> +	u32 node_id, field;
>> +	s32 status;
>> +	u64 value;
>> +	int ret;
>> +
>> +	if (!info->attrs || !info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD])
>> +		return -EINVAL;
>> +
>> +	field = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD]);
>> +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
>> +
>> +	node = xa_load(&drm_ras_xa, node_id);
>> +	if (!node || !node->telemetry_read)
>> +		return -ENOENT;
>> +
>> +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
>> +	if (!msg)
>> +		return -ENOMEM;
>> +
>> +	hdr = genlmsg_iput(msg, info);
>> +	if (!hdr) {
>> +		nlmsg_free(msg);
>> +		return -EMSGSIZE;
>> +	}
>> +
>> +	ret = node->telemetry_read(node, &field, &value, &status);
>> +	if (ret) {
>> +		nlmsg_free(msg);
>> +		return ret;
>> +	}
>> +
>> +	ret = nla_put_s32(msg, DRM_RAS_A_TELEMETRY_ATTRS_STATUS, status);
>> +	if (ret) {
>> +		genlmsg_cancel(msg, hdr);
>> +		nlmsg_free(msg);
>> +		return ret;
>> +	}
>> +
>> +	ret = nla_put_64bit(msg, DRM_RAS_A_TELEMETRY_ATTRS_VALUE, sizeof(value),
>> +			    &value, DRM_RAS_A_TELEMETRY_ATTRS_PAD);
>> +	if (ret) {
>> +		genlmsg_cancel(msg, hdr);
>> +		nlmsg_free(msg);
>> +		return ret;
>> +	}
>> +
>> +	genlmsg_end(msg, hdr);
>> +
>> +	return genlmsg_reply(msg, info);
>> +}
>> +
>> +/**
>> + * drm_ras_nl_telemetry_write_doit() - Write a telemetry value
>> + * @skb: Netlink message buffer
>> + * @info: Generic Netlink info containing attributes of the request
>> + *
>> + * Extracts the telemetry field and value to be written from the netlink
>> + * attributes and writes that value to the specified field on the device.
>> + *
>> + * Return: 0 on success, or negative errno on failure.
>> + */
>> +int drm_ras_nl_telemetry_write_doit(struct sk_buff *skb, struct genl_info *info)
>> +{
>> +	struct drm_ras_node *node;
>> +	struct sk_buff *msg;
>> +	struct nlattr *hdr;
>> +	u32 node_id, field;
>> +	s32 status;
>> +	u64 value;
>> +	int ret;
>> +
>> +	if (!info->attrs || !info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD])
>> +		return -EINVAL;
>> +
>> +	value = nla_get_u64(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_VALUE]);
>> +	field = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_FIELD]);
>> +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
>> +
>> +	node = xa_load(&drm_ras_xa, node_id);
>> +	if (!node || !node->telemetry_read)
>> +		return -ENOENT;
>> +
>> +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
>> +	if (!msg)
>> +		return -ENOMEM;
>> +
>> +	hdr = genlmsg_iput(msg, info);
>> +	if (!hdr) {
>> +		nlmsg_free(msg);
>> +		return -EMSGSIZE;
>> +	}
>> +
>> +	ret = node->telemetry_write(node, &field, &value, &status);
>> +	if (ret) {
>> +		nlmsg_free(msg);
>> +		return ret;
>> +	}
>> +
>> +	ret = nla_put_s32(msg, DRM_RAS_A_TELEMETRY_ATTRS_STATUS, status);
>> +	if (ret) {
>> +		genlmsg_cancel(msg, hdr);
>> +		nlmsg_free(msg);
>> +		return ret;
>> +	}
>> +
>> +	genlmsg_end(msg, hdr);
>> +
>> +	return genlmsg_reply(msg, info);
>> +}
>> +
>>   /**
>>    * drm_ras_node_register() - Register a new RAS node
>>    * @node: Node structure to register
>> @@ -631,14 +801,21 @@ int drm_ras_node_register(struct drm_ras_node *node)
>>   	if (!node->device_name || !node->node_name)
>>   		return -EINVAL;
>>   
>> -	/* Currently, only Error Counter Endpoints are supported */
>> -	if (node->type != DRM_RAS_NODE_TYPE_ERROR_COUNTER)
>> -		return -EINVAL;
>> -
>> -	/* Mandatory entries for Error Counter Node */
>> -	if (node->type == DRM_RAS_NODE_TYPE_ERROR_COUNTER &&
>> -	    (!node->error_counter_range.last || !node->query_error_counter))
>> +	/* Currently, only Error Counter and Telemetry endpoints are supported */
>> +	switch (node->type) {
>> +	case DRM_RAS_NODE_TYPE_ERROR_COUNTER:
>> +		/* Mandatory entries for Error Counter Node */
>> +		if (!node->error_counter_range.last || !node->query_error_counter)
>> +			return -EINVAL;
>> +		break;
>> +	case DRM_RAS_NODE_TYPE_TELEMETRY:
>> +		/* Mandatory entries for Telemetry Node */
>> +		if (!node->telemetry_read || !node->telemetry_write)
>> +			return -EINVAL;
>> +		break;
>> +	default:
>>   		return -EINVAL;
>> +	}
>>   
>>   	return xa_alloc(&drm_ras_xa, &node->id, node, xa_limit_32b, GFP_KERNEL);
>>   }
>> diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
>> index ff0dc406c27c..4577bc1a333e 100644
>> --- a/drivers/gpu/drm/drm_ras_nl.c
>> +++ b/drivers/gpu/drm/drm_ras_nl.c
>> @@ -41,6 +41,19 @@ static const struct nla_policy drm_ras_set_error_threshold_nl_policy[DRM_RAS_A_E
>>   	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD] = { .type = NLA_U32, },
>>   };
>>   
>> +/* DRM_RAS_CMD_TELEMETRY_READ - do */
>> +static const struct nla_policy drm_ras_telemetry_read_nl_policy[DRM_RAS_A_TELEMETRY_ATTRS_FIELD + 1] = {
>> +	[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID] = { .type = NLA_U32, },
>> +	[DRM_RAS_A_TELEMETRY_ATTRS_FIELD] = { .type = NLA_U32, },
>> +};
>> +
>> +/* DRM_RAS_CMD_TELEMETRY_WRITE - do */
>> +static const struct nla_policy drm_ras_telemetry_write_nl_policy[DRM_RAS_A_TELEMETRY_ATTRS_VALUE + 1] = {
>> +	[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID] = { .type = NLA_U32, },
>> +	[DRM_RAS_A_TELEMETRY_ATTRS_FIELD] = { .type = NLA_U32, },
>> +	[DRM_RAS_A_TELEMETRY_ATTRS_VALUE] = { .type = NLA_U64, },
>> +};
>> +
>>   /* Ops table for drm_ras */
>>   static const struct genl_split_ops drm_ras_nl_ops[] = {
>>   	{
>> @@ -83,6 +96,22 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
>>   		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
>>   		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>>   	},
>> +	{
>> +		.cmd		= DRM_RAS_CMD_TELEMETRY_READ,
>> +		.pre_doit	= drm_ras_nl_pre_telemetry,
>> +		.doit		= drm_ras_nl_telemetry_read_doit,
>> +		.policy		= drm_ras_telemetry_read_nl_policy,
>> +		.maxattr	= DRM_RAS_A_TELEMETRY_ATTRS_FIELD,
>> +		.flags		= GENL_CMD_CAP_DO,
>> +	},
>> +	{
>> +		.cmd		= DRM_RAS_CMD_TELEMETRY_WRITE,
>> +		.pre_doit	= drm_ras_nl_pre_telemetry,
>> +		.doit		= drm_ras_nl_telemetry_write_doit,
>> +		.policy		= drm_ras_telemetry_write_nl_policy,
>> +		.maxattr	= DRM_RAS_A_TELEMETRY_ATTRS_VALUE,
>> +		.flags		= GENL_CMD_CAP_DO,
>> +	},
>>   };
>>   
>>   static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
>> diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
>> index 9aef097ea10f..4bdd7ed268a1 100644
>> --- a/drivers/gpu/drm/drm_ras_nl.h
>> +++ b/drivers/gpu/drm/drm_ras_nl.h
>> @@ -12,6 +12,9 @@
>>   
>>   #include <uapi/drm/drm_ras.h>
>>   
>> +int drm_ras_nl_pre_telemetry(const struct genl_split_ops *ops,
>> +			     struct sk_buff *skb, struct genl_info *info);
>> +
>>   int drm_ras_nl_list_nodes_dumpit(struct sk_buff *skb,
>>   				 struct netlink_callback *cb);
>>   int drm_ras_nl_get_error_counter_doit(struct sk_buff *skb,
>> @@ -24,6 +27,9 @@ int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
>>   					struct genl_info *info);
>>   int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb,
>>   					struct genl_info *info);
>> +int drm_ras_nl_telemetry_read_doit(struct sk_buff *skb, struct genl_info *info);
>> +int drm_ras_nl_telemetry_write_doit(struct sk_buff *skb,
>> +				    struct genl_info *info);
>>   
>>   enum {
>>   	DRM_RAS_NLGRP_ERROR_REPORT,
>> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
>> index 1765a3130b09..2a2cdd44839d 100644
>> --- a/include/drm/drm_ras.h
>> +++ b/include/drm/drm_ras.h
>> @@ -100,6 +100,45 @@ struct drm_ras_node {
>>   	 */
>>   	int (*set_error_threshold)(struct drm_ras_node *node, u32 error_id, u32 threshold);
>>   
>> +	/**
>> +	 * @telemetry_pre:
>> +	 *
>> +	 * This callback is used to enforce any pre_doit conditions necessary
>> +	 * for telemetry. This is an optional callback for telemetry_node.
>> +	 *
>> +	 * Returns 0 on success, negative error code on failure.
>> +	 */
>> +	int (*telemetry_pre)(struct drm_ras_node *ep);
>> +
>> +	/**
>> +	 * @telemetry_read:
>> +	 *
>> +	 * This callback is used for a drm-ras telemetry node to read a
>> +	 * telemetry value. This is a mandatory callback for telemetry_node.
>> +	 *
>> +	 * The callback will read the desired device-specific field into value
>> +	 * and update status corresponding to a device-specific error code.
>> +	 *
>> +	 * Returns 0 on success, negative error code on failure.
>> +	 */
>> +	int (*telemetry_read)(struct drm_ras_node *ep, u32 *field, u64 *value,
>> +			      s32 *status);
>> +
>> +	/**
>> +	 * @telemetry_write:
>> +	 *
>> +	 * This callback is used for a drm-ras telemetry node to write a
>> +	 * telemetry value. This is a mandatory callback for telemetry_node.
>> +	 *
>> +	 * The callback will write the value to the desired device-specific
>> +	 * field and update status corresponding to a device-specific error
>> +	 * code.
>> +	 *
>> +	 * Returns 0 on success, negative error code on failure.
>> +	 */
>> +	int (*telemetry_write)(struct drm_ras_node *ep, u32 *field, u64 *value,
>> +			       s32 *status);
>> +
>>   	/** @priv: Driver private data */
>>   	void *priv;
>>   };
>> diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
>> index 2f832275ee6e..d39c78a9ed5a 100644
>> --- a/include/uapi/drm/drm_ras.h
>> +++ b/include/uapi/drm/drm_ras.h
>> @@ -16,6 +16,7 @@
>>    */
>>   enum drm_ras_node_type {
>>   	DRM_RAS_NODE_TYPE_ERROR_COUNTER = 1,
>> +	DRM_RAS_NODE_TYPE_TELEMETRY,
>>   };
>>   
>>   enum {
>> @@ -51,6 +52,17 @@ enum {
>>   	DRM_RAS_A_ERROR_EVENT_ATTRS_MAX = (__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX - 1)
>>   };
>>   
>> +enum {
>> +	DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID = 1,
>> +	DRM_RAS_A_TELEMETRY_ATTRS_FIELD,
>> +	DRM_RAS_A_TELEMETRY_ATTRS_VALUE,
>> +	DRM_RAS_A_TELEMETRY_ATTRS_STATUS,
>> +	DRM_RAS_A_TELEMETRY_ATTRS_PAD,
>> +
>> +	__DRM_RAS_A_TELEMETRY_ATTRS_MAX,
>> +	DRM_RAS_A_TELEMETRY_ATTRS_MAX = (__DRM_RAS_A_TELEMETRY_ATTRS_MAX - 1)
>> +};
>> +
>>   enum {
>>   	DRM_RAS_CMD_LIST_NODES = 1,
>>   	DRM_RAS_CMD_GET_ERROR_COUNTER,
>> @@ -58,6 +70,8 @@ enum {
>>   	DRM_RAS_CMD_ERROR_EVENT,
>>   	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
>>   	DRM_RAS_CMD_SET_ERROR_THRESHOLD,
>> +	DRM_RAS_CMD_TELEMETRY_READ,
>> +	DRM_RAS_CMD_TELEMETRY_WRITE,
>>   
>>   	__DRM_RAS_CMD_MAX,
>>   	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
>> -- 
>> 2.43.0
>>

