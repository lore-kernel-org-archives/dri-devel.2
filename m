Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3938A606A68E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IbuzabuD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M89LnGH9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B68A10F01D;
	Tue, 24 Nov 2026 18:04:07 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C809C10F025
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 18:03:55 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOGs1ML1541859
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 18:03:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TF0c1n1qmDgcnQcm1xackrdRCsureoDJdb+lSA5CUB8=; b=IbuzabuDgb2kb6Bg
 QCtKn0wVWujh0ZSZGgtE2XOMW8TcY05NGK57bG009UWhIc0AxuRmZAONJxIYH4g5
 pYH4OgkmAA57QFg6Bzkv5DZQ8YVYKxqGmn0S01LhpDeEC+dY7Fp3ewcmND3aRAcv
 OkNljZt1ZkVbSqDYRAHV/BDSRX937mYjPImiWYqzY1r0gdYPGzTar2ueU1nAlCLZ
 bbWeejHzTqQr+NA2YvuxlqZYWSi840nmhy2u/NYJwpQqwM86bN4H33RNWTvzFIGD
 BWP5VxyLIsHNufXTGhOydZGd7+lrpThm7CHYMa4z/Xcjz8MhyUML2YbNraTqjcQQ
 cvjBCA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5egs8c8x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 18:03:54 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-375bac6bd21so5234548eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 10:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795543434; x=1796148234;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TF0c1n1qmDgcnQcm1xackrdRCsureoDJdb+lSA5CUB8=;
 b=M89LnGH9UvTMsbf+LqEour5qVGj32nHGB3SQxn1D7vV90d3WxVYuHgmrGHtvX93nGY
 Cah4p5+cIny0A9m8Yj1wCwQ1rXLlfLRnNxUP3ykCSRRJY2zjSInaZK+ax2n2Hh5zjseE
 r4gqR2AaHEUc30q/n70Cre/qQ1CyT48z2Ql/LoVCm1i/6qQI/1lKaf4L0seTvPQc5hsY
 c1OIHK40o5sbwJt684r50+E79QAmGyY7eoI6aFMftYlAHm9xiwZidXGBVrLDAsxxfBqA
 QuQsAYyyAa8ECZanjK5poggGh81WVRI4NZiDedfa1h2fERjDd1CNdDGwYDHlvuNiZS3l
 hslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795543434; x=1796148234;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TF0c1n1qmDgcnQcm1xackrdRCsureoDJdb+lSA5CUB8=;
 b=VIgFt5a1sq7iLVLAcJPOoH6IDjUVdBZUbBLb2AeFupTbzMVxsOez5jiLIaD7zdsUvy
 bJUIW6qUNbcCXILroVsXUkgxZO1cDzU8WwOIdr2zSyyNRM0AkfGEGc65D5WSfXBtiKRr
 B6cgCAvDfDthoVY07e/76k9ayUqakKkzklqV8QH5/WA0FLp5GD09A2keJEKSgr/JvjPY
 CYYyphzkwiRv5CKaqQJXKyENvWpaiPQMZBxBNq6574rXWgX8HsHXUyhpd7PG26wamL0O
 7pvP9os542UfFKmdedFWJ9SXRp0QhbKfrUZqVuXBstnX1rZw/2L9jSStxKM2P58dXulJ
 vzfQ==
X-Gm-Message-State: APuU4Z9EYi7o91wpisfTtqMwVvPproMNWENrxsOhmyDolLiJng/gkpi6
 Q572SzuJuuXnsUkhVGjyWxcQD+m4yTj8HQiXF0bB0GNU6FQ/PvNuURRdExnaf/CqG5g+bjwYklx
 +gA/UPF6Fd57iGhQp289eCLROimZWqYhclAUfYhazlU6ZB3p6qiGcNajCrxDGZ+VK71tAyII=
X-Gm-Gg: AZFdTZe7evAdKutkQs1Jl7VK/lxeyfp68YnOCe0ciPSIKHjcgDPts0oo+zKPYlZi4dS
 orilQZhtnNA+DGdsQpx+UBv4WC5131IbI/grO2D7C/rQo1JDy55bW7WkjXxm7klOW3L4xWU6r/1
 KBwd0qY1BUmGJbSaoRDAshWuJmSBaZufotlfhji7BiMs5IdKQeGqRSiLJSQaN3UjRvhwQJy8xJv
 GA5zyuoo7ir7Qd9yBPv2ur+Zxop/sjRvlK81K6rkmalwkx3w7aVG77sC3QsIHwZrdrO3JDoVpdx
 T8u9VuWrzL2h4acbwYYVoNUNYSjHEXOADEJj7Hn/6ykuDbFABxT2GVYSI/EGVAlHl5e9lCHOS00
 MALKCDLGuzxkO7KrAIt9BAJ4uMQMA08U1/6niNziY9duA0KqHGla75/PUft33/FOOJ70QxTFTam
 EF/3347W2ETzqungYUKDE6b4XCBX1jodU=
X-Received: by 2002:a05:7301:8616:b0:385:9424:5c08 with SMTP id
 5a478bee46e88-38594245c66mr17360560eec.4.1795543433283; 
 Tue, 24 Nov 2026 10:03:53 -0800 (PST)
X-Received: by 2002:a05:7301:8616:b0:385:9424:5c08 with SMTP id
 5a478bee46e88-38594245c66mr17360522eec.4.1795543432590; 
 Tue, 24 Nov 2026 10:03:52 -0800 (PST)
Received: from [10.226.48.50] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-386b9bdafb5sm13598889eec.9.2026.11.24.10.03.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 10:03:52 -0800 (PST)
Message-ID: <487aa76c-9eeb-4342-9877-8c5d0a342ddf@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 11:03:50 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] accel/qaic: Add callbacks for DRM RAS netlink
 telemetry
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
 raag.jadav@intel.com, simona.vetter@ffwll.ch, airlied@gmail.com,
 kuba@kernel.org, ogabbay@kernel.org, lizhi.hou@amd.com,
 karol.wachowski@linux.intel.com, jeff.hugo@oss.qualcomm.com,
 carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
 youssef.abdulrahman@oss.qualcomm.com
References: <20261117233442.407877-1-zachary.mckevitt@oss.qualcomm.com>
 <20261117233442.407877-5-zachary.mckevitt@oss.qualcomm.com>
 <awWrm4Q543mvU318@intel.com>
Content-Language: en-US
From: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
In-Reply-To: <awWrm4Q543mvU318@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3MCBTYWx0ZWRfX0slctBfFvqzu
 J2QHvJDbwIzZKFZ6UIl5ml3eXMCp+Kfn8T285aVTcgi8EvBkyGph1wTCagpAOTUIlYF1VBsUq7b
 3s63QcQFScRhhzk5JL3b0j1wPg2cLscl731CFogxY3TdSdlV18A8Ed9z8U+pPYXOfgns83D0I6/
 EztPm0qgDuowTm/ed3ip+6bpK+YfQOb59oWXFZvKTO0Z4JjVo+fsgDvUeGphbkCFWpBJQwSWa1i
 kSA5Fhy4brnObVT3GSNBo41uZ2pMc+E7zqODvOXFn5pOOO+EtraDlSZxrblvcTEzibHVfrzodBz
 5V5Bv59ii9+6ngolYB4KMGcgjVMvZk+z8RfWB3JjYDm+a8sU7FyOFOtAlSI8xN2HmEVO/GGc5Nh
 66cCw1sbW+Mv0l7pldzITjaXL2fYaQKpNT3/OgzWvQ/mIhK0wPMCPJuqAY2rW7UtTjErDX469SF
 9haDrYVoJ1gmZX704HA==
X-Proofpoint-GUID: tvSw7KzkChwg4hvUg7lsHy4BGNtTddwt
X-Proofpoint-ORIG-GUID: tvSw7KzkChwg4hvUg7lsHy4BGNtTddwt
X-Authority-Analysis: v=2.4 cv=Zt54uN7G c=1 sm=1 tr=0 ts=6b05d18a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=BKpwa6Id5kTLf_hP8D8A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3MCBTYWx0ZWRfX3iwU/E+6ruAp
 2DfPG2k8Xej6WuYwbe+enSLwriWYLVxry2GrhuEo3tajdpH3Yab52rpyhYEsFbCD1Sy0UhiaXtW
 hu7cFRzXSY9Jt2iCPlTc9Z9T6z7LgsY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240070
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
> 

Sent out a v5 with minor fixes, including moving mode from u8 -> uint. 
Should be good to go on our end.
