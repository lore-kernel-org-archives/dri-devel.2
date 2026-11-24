Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CC6606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YljUowSR;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JR3n4w+5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3A6310F678;
	Tue, 24 Nov 2026 16:21:31 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5149C10F78A
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:21:03 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOFL3H51873400
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mJq0o03FHPFQQViwE80kGn7rajnxnhmEKjNzYjrNOL8=; b=YljUowSRGEABkA5i
 12NyjGNhYPmsChZwE/Rz90ugdZAy02EG4uCW6Iz1rqpD/O/v2+GlYsgayfpv2Tot
 rOtnem7ZRt2zcOlAW9a2XLxKBqdHnAXkBOIds5j07IuYlOy6Vq5vM4e50/BgwFAi
 KVRzH494WyDqr8Msmg3lrLKMSr0nlWckveSq3+inGdL/JPB5jPsxhZBamm5IJxPu
 6FClp5pNt1VrJTMqP93qKENmzUq59BJJH1T03BEuL1FNFJz13nL5KauVJuydzUka
 p0ejRkRyv9QxyOqnxhpvua/mTDKuq6jJCr+MTD87N+ekFfEM4gV+IcuyOrkEdKFI
 xU5f/Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5cxk8ay0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:21:02 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-38355b03cb8so4707946eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 08:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795537262; x=1796142062;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mJq0o03FHPFQQViwE80kGn7rajnxnhmEKjNzYjrNOL8=;
 b=JR3n4w+5n/EEeWC8VJPbw1kP+Tj8OhFuUFfKgfMQtqPpYOe37X/0UYL/Vq9+R9E5fU
 hYi9ENtSuZITCpFvog/oACelBSkuDPHC/NzkltTYoX2XvQvxhIqoGE0w2/w10wKhTAQN
 p3hD2xwakPQlSDoMRfsnxBcdMPL+VPY0lMgCTaFMnX9bx8QsNNe1I9YSrUxVEa6Wf2Bb
 rJR0meWrIw/PQJAP03NYJZs7Xv7x/aYNXgqejNDfszGP7x3wlCB+Z1lOdvAORQ9wAYnZ
 akDP62Y3eIE0fNpRPUq8SpC5gcACYD28CcG5oUTETq4tlViGKGSntIAcdhvQUaaVdzPi
 OTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795537262; x=1796142062;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mJq0o03FHPFQQViwE80kGn7rajnxnhmEKjNzYjrNOL8=;
 b=k+Wk6UqKB+nuVDPT9CNK12k7Cj/sCHgNpxMu77/7LqEAAUUeapz0sviC6pfrkqexud
 3iPGpiJoPa7rHQpoltiZY+gMwtJ9bvRnAcI4t5Sb0/icGhtliQFGJL90tqghoptdxquf
 1nLs0sPYLxnDQg3RdqM8RptfpAMlMJ+wt81S8+tgn5oARR8u4s/PJr52UHw5N4hRh58F
 NDNio1vd8yVw1y7Z6bg0dfGq4P098TBW1Hycmfwy6MElyDXmjpWCyQaqyh1FKpGWrEPu
 icuXFpKVbPqrEMcL2tWZ/0INaCJeGz2x8WzEX/j2euMJQ0tIoJ2MW3bTUb+0ABP3d95H
 LZ4Q==
X-Gm-Message-State: APuU4Z9f993rMPi/3OhM91M4D9LyIg9sMDHP15IUaOg0oS46jVr39UTC
 AKso7K7FFMNoD6oKnglxdNKV4kM5MEaSZmfLR2vB0Jk+kSMAS5hZp4LNus8aachJr9VC3dKSAOM
 mz9zvuZHE1VZi+TLdtTIJoDbtEx4GTzyBibXXERyyZB/0wQVqtQpb9UOpS53JJWyvQmkOKmM=
X-Gm-Gg: AZFdTZfmDJkKP17Kx5rHLYcRw1op5L1bMAVkk7jdzNMqbyD6iTJ9cTfnzeos2CAIt6J
 4UMxv4qACY5TCfyGAstLTbdk976gVsHstjdzcO6sCPC2U8zKF5emON3htbHfS+lDXfKU5qdv5Wl
 qRPeBWvRw4XTzYEqgMVFD2ddy+t1aKcPxBN/2QgcBjvFqYu81eTDbR8znQueZ347KjnySPTcORV
 fzgvID3JHbvqzAbmpCjpE1urOcdEfuyeNlG4Ci2Bj3opPVxx23tDwzDiMldNluGXDo80Gmnvg8+
 Aym/xLAxe6xTyAymG57EOG+V8xzvbWP7hSwP4c1w2AaFd+1HLowwZHI+DxN6tWj4jWGJqoQsW2k
 S0lSHNO7C0LIOiu54vHeDfEdgs9SJgE4mqvzMS41kuJYxq9UhYAdxP9q6XlyXeH9/PRUleXqdQz
 9E0r28x2ybO+PiXPsAgpuSNOc=
X-Received: by 2002:a05:701b:2508:b0:1b2:3497:5998 with SMTP id
 a92af1059eb24-1b5568f03abmr13957295c88.36.1795537261717; 
 Tue, 24 Nov 2026 08:21:01 -0800 (PST)
X-Received: by 2002:a05:701b:2508:b0:1b2:3497:5998 with SMTP id
 a92af1059eb24-1b5568f03abmr13957253c88.36.1795537260729; 
 Tue, 24 Nov 2026 08:21:00 -0800 (PST)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b56ef9fd16sm24508184c88.4.2026.11.24.08.20.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 08:21:00 -0800 (PST)
Message-ID: <6dd9fb59-3043-403b-bf62-a2d204f8de85@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 09:20:58 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] accel/qaic: Add callbacks for DRM RAS netlink
 telemetry
To: Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
 raag.jadav@intel.com, simona.vetter@ffwll.ch, airlied@gmail.com,
 kuba@kernel.org, ogabbay@kernel.org, lizhi.hou@amd.com,
 karol.wachowski@linux.intel.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com, youssef.abdulrahman@oss.qualcomm.com
References: <20261117233442.407877-1-zachary.mckevitt@oss.qualcomm.com>
 <20261117233442.407877-5-zachary.mckevitt@oss.qualcomm.com>
 <awWrm4Q543mvU318@intel.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <awWrm4Q543mvU318@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2NCBTYWx0ZWRfXwJeuP4fesY5e
 Lqq9SPvbHcCZq5rA3orjfHvz+8jhmck48R0m/TCzj+NoAfGo0OwmnoF4i5Kg74L/lz7ySi0KV50
 gHdXvAMEE0aRVupEPnmZNutaPO4uHYWcUvShYe5YlYU4tJQxFAyr4xWqKUTCxoe8uLB2yEYlVX4
 2P4QBVMdvc6v7idNwK73Hp4wJ5czayk2KGhJzT4b6pUqt83VIkWgSF3UMCy0P0TgMvOnErXZifi
 1gCamLUbb3V2V/79SAKY6G/9acCQ6Hh/2enbdSw91cQuUwShx+BvRmLgFa88EDxudFGVUy9QpL9
 +TFdwbd7JWAnCOD1IZnLy1nDtjd7GM1o+h0umjIJDvoj/qK25N2xU9JeVYfTAuPAp5IyMmYhR1e
 qsA2XQnAOMBl14F/XWzih7zKfL/VA7AnOs0rnif4REz4WEipBhAXVmr9dHOgzmY5Knz8Cw8e8iZ
 TRXybkPWLdbvVxBtq8g==
X-Proofpoint-GUID: JFsNSRUqnRyd3jQjNAZ0pnBmT5-CSnFO
X-Proofpoint-ORIG-GUID: JFsNSRUqnRyd3jQjNAZ0pnBmT5-CSnFO
X-Authority-Analysis: v=2.4 cv=TLbQ2Fla c=1 sm=1 tr=0 ts=6b05b96e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=BKpwa6Id5kTLf_hP8D8A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2NCBTYWx0ZWRfX+6OmFoMlpA79
 r8DFjJy7ABh9ToZrdxqu8fpn2jd5Flwh8yF9XZZ02g5fLvMX5ML2LRlj7F3tjZkrxBrjQEplYDb
 ga9qPQenPWzUuAvMillnVt+Cl9tWhpU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240064
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/2026 8:22 AM, Rodrigo Vivi wrote:
> On Tue, Nov 17, 2026 at 03:34:34PM -0800, Zack McKevitt wrote:
>> Use the DRM RAS netlink infrastructure to perform device telemetry.
>> During MHI probe, create a DRM RAS node with DRM_RAS_NODE_TYPE_TELEMETRY
>> type and add callbacks to telemetry_request for read and write operations.
>>
>> Co-developed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
>> Signed-off-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
>> Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
>> Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
> 
> Can I take this and the rest through drm-misc-next?
> 
> I have another series that will conflict...
Yes, you have my ack for that.

However, Zack mentioned he has some minor changes for a v5 that he'd 
like to do. He said he'd do that ASAP (today).

-Jeff
