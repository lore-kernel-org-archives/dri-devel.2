Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4096AF364B7
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 20:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7A8410E8A4;
	Thu,  9 Apr 2026 20:23:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SVMVhu6M";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UXt4x/Er";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E1FA10E8AF
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 20:23:04 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639IUDY3779768
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 20:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yAm1FyXVAl2rw2SiWlWKegNh5tcyNAIhWj+e+79Lzlo=; b=SVMVhu6MyGcYZmHE
 B5pO1E/XFaKr6Dz9LBq4FW5XRQOCd4wPVNxtuhjXDYrD71Z1k0AcvzgmbDv0I/Rq
 5eSj04rDG58BVbn57k8aY0URYm0Ni7SS5nDX+WONNvBQJDuUcEg9x+lcWB7YSxbo
 vJKOjlaa+o5daZamgV1LNdush0ZK72uVmvBwWWbeC2XOpC1dpJG/JPOAD5/7FCSO
 ut24fZ8n2TlM27z4+rqedyhAd6KR8FN/0pDaTOod3ZApu1oniXiaYUMS+3K/yHzi
 0he3Hq9q5bzEIDRqv7ezGIJl5p3Splt+2qdc65QBE6Txp2+2wQo3hvzcZaKR4Nex
 sgxjLg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dec8hsstu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 20:23:03 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ba9a744f7dso1526482eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 13:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775766183; x=1776370983;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yAm1FyXVAl2rw2SiWlWKegNh5tcyNAIhWj+e+79Lzlo=;
 b=UXt4x/ErcJqM0gj9b4d6CIPj103PDOD9XyRJmmql5/YfXyW4ntwYuU3bIWtbvkpKGD
 EJ7tacMWcJ36okxfXDheiYCUyTSl2+0H419wYlMYHTHZv66wuxL3mvug06CdhT0eCviq
 o84SeVrNEvJdXWytRZMUl6mQb1R8d+FyaIEdeShM+2y2p6Y7cZ0TyrCGUXI/qgGbvybe
 +QRMesruN0t840zt0ObcNMvSNbHbcIJCEbs+SYIJutFRSuovmAP5iQxlx8GGLLu356/F
 HE0Xp9WBwkU0AsOVPByiHbU9Q+zcul+eZmEl9Z82e88rS0ltzTQrP3lslLV8m/lnLY0J
 /3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775766183; x=1776370983;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yAm1FyXVAl2rw2SiWlWKegNh5tcyNAIhWj+e+79Lzlo=;
 b=RFvAcq6Ec7fHlUcYy7dzvvkZkJmYD+L5xioYE9njGzSy7QG74E1q/wiHNcvJzMk3Pn
 bVjpVbEJ8f602d0blyMNEIn3yE4yJyAEykdhT+DLrPOAJXEn8mIN0Y36rTU+/QbRQl+V
 TYyuOyLsWK4XVOe7oliWSTjr3hkC5cj0GzSKsJgk7zvfBL8AnvhR/6Fb3LCxjH69zOH0
 LOUoi/5WKyL8FBjh0goGVq91OtH90xKHq9xaHhgIBKkdqcdXzMN1hc56FJwBwxk4RQuT
 6P0GOyCAKZtuTQlydsTaYcJRz4HXPDoxM+DzRZGbZmZxkjfUOU7xeIWgj7eifl0WY2fM
 OWHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk3D9qLTrtg6ZttuEBQpAdgphhD8j6vvplZnIS2bdmEA36peJ+Bw5XXGSF7fpnEKsssMjme/nAjTY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz4kqOJYqrI8+MwVcsA9RLWxLlMVUlAw6Ts8VcNnYxaoIjnTWw1
 lxUPnNSYOQao93ZzuHmG4uR/Jw+MDGnQOVtW8N/y/ikXtLNDa2P2wpO0leYqirGOFLcpbD7RnmY
 GQNjVy1AFx2TJFFPKgAcVplJy8fMlcwTjeoEiizm3YWGl4qc3U4bs+48OmRX4vJ7r6QXy9VE=
X-Gm-Gg: AeBDiesRPkLl/Wm24ZFmKUW/S4jZEKoMglj2phkvuZL1CUDGRHfvz+E/0aphn0h+BRQ
 388QpVUK3SYByRhM2nRFr29hyvBRJ1joD+bHIGxdqk7K9Jk8VUGewNdFf0CuQw/Ah4CiQvTYzAZ
 0zYj1gv6kPyltocUA6b+8RPMf5g5ggEXKt1RRhV6ZddL3PmLBEzIOwddvmI/QrUunZ87YQByz3Y
 ShUlkHczCCBZX84PrjmSrpJ41Da22J8oI6Z4g/SSLm5bluySt9D31IXm4SfkdiK+Y/SnQXdgsLG
 NYETWpCyFZoNWAjWLNoxveKucBDQtjqoESmEjid8xMG9nJ+FjyI+gh8NlRQOzDOZ+wnmKZcL196
 +2ooSV5HTWnWRpoT1h/eYZArIr7AQoqHblVZBLcQwwsIBno9kX24rDDkiRFcWPGpuTg9KsQLU+0
 8=
X-Received: by 2002:a05:7300:bc8a:b0:2c6:cdb3:bd67 with SMTP id
 5a478bee46e88-2d5897690bbmr312310eec.22.1775766183131; 
 Thu, 09 Apr 2026 13:23:03 -0700 (PDT)
X-Received: by 2002:a05:7300:bc8a:b0:2c6:cdb3:bd67 with SMTP id
 5a478bee46e88-2d5897690bbmr312275eec.22.1775766182573; 
 Thu, 09 Apr 2026 13:23:02 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d562ac344csm1137899eec.25.2026.04.09.13.23.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 13:23:02 -0700 (PDT)
Message-ID: <7aeeed43-b458-4c68-98b0-e857f1ed791d@oss.qualcomm.com>
Date: Thu, 9 Apr 2026 14:23:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] bus: mhi: Match devices exposing the protocol on
 the SAHARA channel
To: Kishore Batta <kishore.batta@oss.qualcomm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, andersson@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev
References: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
 <20260319-sahara_protocol_new_v2-v4-3-47ad79308762@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260319-sahara_protocol_new_v2-v4-3-47ad79308762@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=PMM/P/qC c=1 sm=1 tr=0 ts=69d80aa7 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=3E-APKfXKu7q0kj6aHwA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: u4V3L9Z6CtwYZQy9ZlnjjjYsX0dvAhOH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE4NyBTYWx0ZWRfX5qEwu31919+1
 1kJYUVF6jXhRRS/SKFkRSMWnyrESHdwJl+3b0I4zryockxkXnTrcZU0LJbrXfssZUG23znQeyiI
 vcYx3cQhKAp2IXnhdUeL/Yjuy6lX/E5n2S+V9RKQqP42MKf0wghi7EcEVRu9leZO7DFPgUnXPZK
 Y9WWzlj499wConFEKX1Iwt7u1BlDJwOSQjW/uyp529J3Z4YN713rnWSBdMHaoZR1y4tLUVyc22o
 FQnsaPqlncoNujzXuN/mGE/kGDPc9x8Oka46Yy0m1EO/d/v/tuSc4yFNHzy7EzLo8uc1wDTEAQ2
 1vdaHbOqHK1HeCOfVJ5kNyaQCUz8v3BzsP3rFFpD8zwDcNoduHwILGggXZFUlc1Freux/CcmMny
 xkQW9e7HuUtGslJeeWvwLWCGtrFLh+q4mI8ItLqrrkdDOwPp7W586TUzuvCGwfprYmnwULZnvBz
 I094DgpyBZdMsk/ycnw==
X-Proofpoint-GUID: u4V3L9Z6CtwYZQy9ZlnjjjYsX0dvAhOH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090187
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

On 3/19/2026 12:31 AM, Kishore Batta wrote:
> Some Qualcomm devices expose the Sahara protocol on a generic SAHARA MHI
> channel rather than a QAIC specific channel name. As a result, the sahara

"Sahara"

> driver does not currently bind to such devices and never probes.
> 
> Extend the MHI device ID match table to also match the SAHARA channel
> name. This allows the Sahara protocol driver to bind to devices that
> expose the protocol directly on a standard sahara MHI channel.

"Sahara"

> 
> Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
> ---
>   drivers/bus/mhi/sahara/sahara.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bus/mhi/sahara/sahara.c b/drivers/bus/mhi/sahara/sahara.c
> index 8ff7b6425ac5423ef8f32117151dca10397686a8..e3499977e7c6b53bc624a8eb00d0636f2ea63307 100644
> --- a/drivers/bus/mhi/sahara/sahara.c
> +++ b/drivers/bus/mhi/sahara/sahara.c
> @@ -911,8 +911,10 @@ static void sahara_mhi_dl_xfer_cb(struct mhi_device *mhi_dev, struct mhi_result
>   
>   static const struct mhi_device_id sahara_mhi_match_table[] = {
>   	{ .chan = "QAIC_SAHARA", },
> +	{ .chan = "SAHARA"},

This doesn't work and breaks bisect. At this point Sahara will bind to 
QDU100, ath12k, or something else but not know how to drive one of those 
devices.

Just add this when you add QDU100 support, which looks to be patch 5.

>   	{},
>   };
> +MODULE_DEVICE_TABLE(mhi, sahara_mhi_match_table);
>   
>   static struct mhi_driver sahara_mhi_driver = {
>   	.id_table = sahara_mhi_match_table,
> 

