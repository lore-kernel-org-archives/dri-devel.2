Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC0810F284F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9427810ED9C;
	Fri, 27 Mar 2026 16:46:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bjV/DUfK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HWrf2CiX";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B3C110ED9C
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 16:46:36 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RG3V8O1955599
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 16:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +/my+npTTxhyEzTWA8+2uihSbKgAQuOqTr8zXpMPeT4=; b=bjV/DUfKP2ZU+K08
 w7n6PD/kEdxrfwtjNSNV8WbTwu7/fPdldnlMaWOxkONCM+1pD1jwvdv1Rrv4TRuo
 B7GGvbw2Tg4HN7xajQKOFTlpcf8DVsPIdpWOFZuI8A+ehewU2I2WvlSjBMdC93hW
 eUv+M9nMY2fhp7q/7+KzyaEC8Ge4MhP5iL2CgkzeZYH8wJ6gn6npMvYsfSVvEr+s
 SL7HvDAuZT6OsLzHur0JkgndoJd1C5pRPQikCWET9q7i416EVeUxnC6puaV1Ozg2
 Z6ACvwQXj6HqrjzJaC6Q9sno7uzg0EIRLI7C4GJRTcVQzCjMbN03PhFvhmzPsPUd
 Y8YtzQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5w30r5h7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 16:46:35 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2c16233ee11so2199675eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 09:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774629995; x=1775234795;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+/my+npTTxhyEzTWA8+2uihSbKgAQuOqTr8zXpMPeT4=;
 b=HWrf2CiXi+iWcgGNx7HRP2sbIMHzXS7gyj22qnV/fWqKiapicXEHGe9+LXWqzF9+mQ
 /nInerECLdeb/8yKp+WGy/86Q3MbZsQkWFIVaRhfuWG1HZrBR9Zh9/CFo1xlPXHoDxsr
 O8aCAUxseqMN+3QWu6rsbceHJaIbkjBaCD3PEkqXtupaIpU6jgSZedlpyhN48GywRMiH
 q8XNLxKA21aOBmEJFU+yHSrkP6kZEXOTozZsaj6eIRS0jir3ISODLUqJsVDAzo7CIvTX
 a6ptNxihB/UnLXFQo4joNmiY/xCr4ijRrUShxdrvdYdWS6LeVEvCP3dv827VSSK89FtA
 W7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774629995; x=1775234795;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+/my+npTTxhyEzTWA8+2uihSbKgAQuOqTr8zXpMPeT4=;
 b=o3JeYyUl9YKdZQ2otXU6sFLivYeVZStrRB7ChE4QoobUYCXmVENddk07ZWpqCLeNOL
 atH9F5wJpz8y3qJRE6G9xexoDWUEH5HsE3EnPzIA3rI9NppnLEzXYBiV6LaiFp1liLVa
 k+mowu8qO5MKAtbQQIX2xMFHYTGTQr9qxJnIiO3NV7mNgWgYTOUDPYjqOZ2C3qnJHV01
 layR/Wer8vCYJBke1rjsxzEkSIspVSZFZMrS1yd0w6Jq2WLHKeRsgl6aPKY5rhzKi2OD
 GB/JJ8wo6Lw1ekb8j7mOVsX+u+fbHgIGpE7ojivIb5M8j4TOdGiTEw1p+qbPcVjiuIUM
 j3Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdzOzcgf1ohf57Ei9ZxboFHRjCREm4b9agUc/Fkwr2iJ60YDGm/rHWvzi1+WqIxpimlab4dOciwYU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwAvNFNFrRRtzQjhDNbCZLewtK3VcKwjJLGvaSNjL0yEI+CkXOv
 0JqEeXTt+DrbsViuzarbZbOoE2PTwBaiIW7GI598hHMKqbuQ5YuBqG+HLnUDFv/UlYvyev9MV+X
 LItYjoCmdsR8wBeJPHscgF82b11pYq1SPL04Pzs2tZfOomyBe2x53zne5qr+BLKgcFiUmn3Y=
X-Gm-Gg: ATEYQzwaPtEvFPtjh3ku/iu83dUG36+DhcTrOtHrVlFQThsIthn5nRzwVcBdfSq152F
 BEQJtWWqbK5AJmYlzO8/bB7E7sRRYY06jUVNmDNATs/ffGUtgWw+IAmXseThgUqLEuPSq0HmBUY
 XpxdERfi36QgrtnHOh4zg5gv3tIc4Z9aHdVoLp1xgXGu+tJxfwu+JkJ/8+AK8OcXWU+whThOljD
 XQtT+8YmiU8qYH3ePNOacfyHut1YOnDzkkQW7bnofmA3ME6cblwXrU8EXzHnLFz/JLHI5nXr8ku
 H4lhYeGcRJ3H7Y3w/CR3zsjFE0R8KZNkTaHM7YlYjnjiksiEI9ESnuBXVe+af64TjWluCvVkQRP
 kErQ360sx/Gq9id5d6blGQgxf9pelneAK2Z1ZrcmWTK2bjhhK+wf5orsxZR2hwBtaABz5/bSgEe
 Y=
X-Received: by 2002:a05:7301:169b:b0:2c0:f15a:ecbc with SMTP id
 5a478bee46e88-2c185f5e8d2mr1571556eec.33.1774629994796; 
 Fri, 27 Mar 2026 09:46:34 -0700 (PDT)
X-Received: by 2002:a05:7301:169b:b0:2c0:f15a:ecbc with SMTP id
 5a478bee46e88-2c185f5e8d2mr1571535eec.33.1774629994253; 
 Fri, 27 Mar 2026 09:46:34 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c16ec47293sm5525109eec.9.2026.03.27.09.46.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 09:46:33 -0700 (PDT)
Message-ID: <eaa32b67-53c4-4194-af33-fb83623c6f0f@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 10:46:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] accel/qaic: Handle DBC deactivation if the owner went
 away
To: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>,
 carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
 zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, karol.wachowski@linux.intel.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260205123415.3870898-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260205123415.3870898-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8IcxNy6gMPW3nrvQaJGQVOP5es7Y8BQJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDExNiBTYWx0ZWRfX2j8b3Orzk7D8
 5qe194wYUzcO3NOH+enaRtN6XZVmQahtlDB6+i1tXagZNYUPtcQo2qc3loUfQqRnj1GB1iNs9lP
 17LFKf/U/0e0g1k0MfKiL0OwlxKrrkQltbwsVseFzpAeUhU/rrCDvh4uLo/LMvHnhfjBYvMOCKj
 4i/Ioqhr5aOt7NyCh7R1PbNMyuGAJe1ChR4zNDVgArcMG7hdaHRggLTzCWGyktOufowLkvJe8we
 JPVNVEiG/GI0N0Mg6p+9J4vCD6VIvgNigfqKmfIAW/x1hhAEZWWf6wc0TX3jZ+x+2/96ZIQ9uAK
 5VcYIriERVMCtrYIv6fB4+2w98ZZexmaGMAkGxy2Y370WTaL3EdjC+unzczqpsKHlXfhF2+hew9
 YG5oFkglNxyHVRGWvQqeCcQDd4f8y3sxcmhJIcxMsaXEMwvmxex1Y01IGhpgNGB83in9ECvbxCX
 KAmpPXcq9qsRoS0FhxA==
X-Proofpoint-GUID: 8IcxNy6gMPW3nrvQaJGQVOP5es7Y8BQJ
X-Authority-Analysis: v=2.4 cv=F9dat6hN c=1 sm=1 tr=0 ts=69c6b46b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=TB8fjEhHHLHokerti4YA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270116
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

On 2/5/2026 5:34 AM, Youssef Samir wrote:
> When a DBC is released, the device sends a QAIC_TRANS_DEACTIVATE_FROM_DEV
> transaction to the host over the QAIC_CONTROL MHI channel. QAIC handles
> this by calling decode_deactivate() to release the resources allocated for
> that DBC. Since that handling is done in the qaic_manage_ioctl() context,
> if the user goes away before receiving and handling the deactivation, the
> host will be out-of-sync with the DBCs available for use, and the DBC
> resources will not be freed unless the device is removed. If another user
> loads and requests to activate a network, then the device assigns the same
> DBC to that network, QAIC will "indefinitely" wait for dbc->in_use = false,
> leading the user process to hang.
> 
> As a solution to this, handle QAIC_TRANS_DEACTIVATE_FROM_DEV transactions
> that are received after the user has gone away.
> 
> Fixes: 129776ac2e38 ("accel/qaic: Add control path")
> Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
