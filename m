Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BBFCA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 16:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09EA610E192;
	Fri,  9 Oct 2026 16:46:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="J9wzBeC1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TLnEPoOX";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D256110E192
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 16:46:42 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699GbGvE2343530
 for <dri-devel@lists.freedesktop.org>; Fri, 9 Oct 2026 16:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0c+hPPuZJMciduKCB+7u2OKS+iRv4VIoibS22JskZXM=; b=J9wzBeC1RRMLly+H
 ufr1dAWohSFu8SZQAvpumsEcAYTzglrz05mRQLXFT+dCeoTEPVtsGKMM3fQ5EGc3
 Mk91YJFGvPD4JEZi0WAjjjOXJt7JLTlL7xYEXFWXjSS6mo9pFivMiGtKy94I6d/t
 tuP+BzDWLpArCckKU/CTq0iiES+pyztqFbAKWfv56dHrS0x0J4afT+WUwi7BLEQL
 qLhDb1eL5Mw0XRBRzuYGtlsPR36U4DX//eX9V2Bu02vohlEPBboMExgoSpc0vHnY
 2dn79eOwOwzkSSGpGbjKfyg5f5kDV920HCzL0dc8rYM2m7u6+vLX428g1f/hjTGL
 ZpFlxQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6yk7h69t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 16:46:42 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-8210034ccc0so10646a34.1
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 09:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791564401; x=1792169201;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0c+hPPuZJMciduKCB+7u2OKS+iRv4VIoibS22JskZXM=;
 b=TLnEPoOXz3S8xLbAE8ZhijPs3L9KndhmqUjEkebrAUECaOgEEDnmQGX1aWyk6mZgKi
 iWEq3xz3jj2tjInyTIstuB/ibO6vE++BwMJCUrhCWs0HX+bo/dhJgoiUMwVlXyXwgrPI
 sEfqiKgcDuXdGe87NXBFxy0QvHnOS8oTpdDpLSKenotZi2LX2ZlHttboNTiQx2CPYLXA
 52JJD14Rbvj3UK7sAp72yogFOQsgSLzRoZ2XHOtUJAVSsD7GZiEv2V7AbUwdSR0QLqYm
 xwbIQgtU632Zdgc7CLUiFXCukO0t107yOz4PoAg4r+Iv9LuI9H4lE+xPM45GsJLW6WYI
 tzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791564401; x=1792169201;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0c+hPPuZJMciduKCB+7u2OKS+iRv4VIoibS22JskZXM=;
 b=CCuYWIj5DlUuIwbHt41NZEkFy1bo1FneSW1XAKzswWqUXeaQubO30Mhkaxox2pWvVu
 /V0PrWf7ME9aQOPgJncWQ3yss/pWM6xcqCE7PQQ3ObLGt327BQga7M5SJL23J+K35bTb
 XB/dxRCt3GLLDbKV4pLciy+zfqtPhvN2SZSqRYfUjH/XalMqgD7NT9aJdyaaIpQ1QaG1
 dSHy1qcq0FGm+3Hhkz5adMrCwbjv/0cKiB/G38CNN2NHXRQ2EDllK253jhXUT/y+5u+c
 d3iaTDK6S+BGBRKAndFPgQ/k1q84pydnljSVFspcQm7Q5AU5QrATXmDN5iPNl/sm9yhv
 B/eQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy67xWKnQl4cDM9cBCzTq2HxuV4HNydNNrwNpj9aE8wIhePNBdPNmCmFmWUGTbP7HXgQzy+Wa+tbWk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lk0CdgUJVRUnvDCrnaOQNKPzbDJt/URxX0an9KZPslWwHyQklE
 QckXbFr6NSWWZLGIx09iy24I7IUruAhJ8DL5CSd1iFz5bop6oBFakzryM8rxG80a/mqiD6E5/P9
 +WEC5TkyNlz0LRAnOMXETDOOxGQAa9yYVIjORFRMR10RfktfDEgkVotEuMWPyT5nzADAnrSk=
X-Gm-Gg: AYBFou3kk+nALfpZyjOrPYBxZgCofJqqey0l6GhREtSYRGeMIptJDG5x3+oSL03b6B+
 +r2O8XpTxAGmKB4dZdSqbDFmZY3dAVi2ZvcEolT1CU91260hzQWDsIhb0pGVrdQFooe1hUZw49Q
 KN43Daqf9II8tJVc2AnOIV1IiE/1hgAhlhDwTE9AClDCbcIutPyJmZmHY4tdRxURJEBcr9ALBtb
 dwDEssrmZhkgW7PtI1RJRRWDjKCLeg7coDHmnHHZifkBLEPb1ZgssMpQ48oxZjFrncj/xGPhEmS
 0+W+UqPaIJ3bbGniejsM02rbEvbcJEGG/0r/3z2+dRSfk19/R8bV7kpIYhePrpqkPsfuzzWqr5/
 D1cFwaZygM9TCDMVAyRQjCzuEaaJih0owctmWzytiUrs8v9K/rw==
X-Received: by 2002:a05:6830:6219:b0:821:cee2:489e with SMTP id
 46e09a7af769-83090e18eaamr2107667a34.2.1791564401566; 
 Fri, 09 Oct 2026 09:46:41 -0700 (PDT)
X-Received: by 2002:a05:6830:6219:b0:821:cee2:489e with SMTP id
 46e09a7af769-83090e18eaamr2107654a34.2.1791564401109; 
 Fri, 09 Oct 2026 09:46:41 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-830385b9c4asm2166210a34.9.2026.10.09.09.46.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 09:46:40 -0700 (PDT)
Message-ID: <1d263f18-c99b-411c-84eb-0ee5c7b76d36@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 10:46:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] accel/rocket: Use an unsigned index to copy the
 job's tasks
To: Sidong Yang <sidong.yang@furiosa.ai>, Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20261004164727.466164-1-sidong.yang@furiosa.ai>
 <20261004164727.466164-3-sidong.yang@furiosa.ai>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261004164727.466164-3-sidong.yang@furiosa.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=D63SufRj c=1 sm=1 tr=0 ts=6ac91a72 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Lwc0v0yrVDlXq8EuFrQA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-GUID: ACVpZYThtmICYWLNVk9yqhm2EahOULzi
X-Proofpoint-ORIG-GUID: ACVpZYThtmICYWLNVk9yqhm2EahOULzi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2NiBTYWx0ZWRfX/VgFwAnMFUUJ
 6ppXulGP35B58ZvH5TTbA99K4Js9/X80M1OH1rmIKmQliIbHyz5GJhEDuFuCtD5ONgZKViBFuHC
 tsScg7R9KIJsj2ClzDrCFbcGVM86XJq+n4Ea4fr6+39vG1oTsXLsiQNEuZ1vgLUfcMmu6GVVwx1
 2u0X4zimXD44dArqvSBF2FKAtnoVUX9O2D7DhICSWkCjELhyRfGWmwcfM5r9bjMutFvkdlAy8qL
 COCaUKHqbyWcNhWadznC2W335yJbM8vOZBP3Luf1noroGL1TXGftFzl5eb10s8vWjkXIx+KcvMq
 S7daz/t8+ky7rCWrB6s7SgNcbC+DWJueo9k2UXCvfujiBT/n/40uSmo99e8JRZCKnLnt/+7xwGU
 cmsOUF/8NMHsynaIBDlBOGibPQYftxz7dWof8NoMGMVFP+OCD7ODHCOK6An9MwDonvUHm22oytv
 m9inm4shVSdNoPib0WQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2NiBTYWx0ZWRfXw/CJQZhf7Zm5
 Ohgt96qGMPS9gcEMl00NMh519FCj0gMbvjhuBxOB8NdGbVDqOO/iuQORdPQNu6Q/7h1c3RrkQXu
 RZ2QerEOBlOlg3Ui+hQQ9OmJrgzMikE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090066
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

On 10/4/2026 10:47 AM, Sidong Yang wrote:
> task_count is a u32 from userspace, but rocket_copy_tasks() walks it
> with an int index, which would overflow for counts above INT_MAX. That
> is not reachable today, since kvmalloc_objs() rejects any count above
> INT_MAX / 16, but use an unsigned index to match the type.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260711063638.61B411F000E9@smtp.kernel.org/
> Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
