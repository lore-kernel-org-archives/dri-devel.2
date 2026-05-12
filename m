Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5EACD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 16:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 607B310EB86;
	Tue, 12 May 2026 16:14:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GTuxMx0d";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b2xMoh7s";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A957B10EB84
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 16:14:55 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CBxKkj129119
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 16:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dearZrYdES8kldFVf7isD4SpduWQxApzD6N2MFZnRNE=; b=GTuxMx0dzEzVi0oi
 355AdHSL1hNFcMHDkJ9/94Dt+X6CoZ8K0GBaioGeYh00BXK0GZ0LVzsK7qzbbn6d
 jHEIT+ImCe2/kVS5UYAJ35/OVcoJIjqQtxnMHV/7Nx+B5upJXGAEwRpyo4eKd1pY
 uMAJtU/9tv9H6ZAlNTn+Jv0JqU9jzyraw31Nv9BL74RLL5zu+pCQBi4cpiOVYx0Q
 /FWVCoX0jou9+RBNVbwgOimibZDgrG5kWCgSISvkza8uZgsck4XmKtcII6TZCv+M
 sTe/KhPLfhyzxCm6bSYIAHmtpOU+Mk+wHYwMu5AuJDvNjc/XXBT5NlOBFFGHoRoK
 bxS2pA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e43tn10a2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 16:14:54 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2f3ec2e8d07so10059482eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 09:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778602494; x=1779207294;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dearZrYdES8kldFVf7isD4SpduWQxApzD6N2MFZnRNE=;
 b=b2xMoh7sdfbCxZK2M7lvsUrOHjbC1TphYrPxbBgpRKIJZXMF251QCoguw6r88VMKjk
 47TefckHCwWeD2mOxuz0yxYmlwR4it+S71UUu43Cgei1SiCMufRu0W/7loZR51JtX2Vc
 XsdVL2AC18K0yr4Kc/V4DUu21YHT3wR1kI6FAfq5zXCORBJNRCRDq5+uwNhz6PcbGJrh
 eSP1q0eY8GzyOMUuRMvllMisg38ndrlVMKwZhQaWJOZs2+pIl879jPNyqP3dJPq8TWTC
 eQFXPPxjMz4cHeI1vIhrxyLVN1OxCJuXHqmp3gNGj87k1auaOMsYRmXDViWN6+hrmOdh
 MeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778602494; x=1779207294;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dearZrYdES8kldFVf7isD4SpduWQxApzD6N2MFZnRNE=;
 b=hxQMy4x0FrSC07bz0lnUFByt/7OCrd2YOIWulCd+vJl8cFsNC6ePTVFZ8MAfjrxxo9
 lYf3yOuxprw9u0mFLiuejPj+79/n7B2p3ONbfjLTsojCdMtw4P0+ADqy7aeQOS2KoZDt
 5DTxTbrhb84aQvYDoRc0hqjijgMv2Uh29C4grwdPBcTVxkUXTjCJPqnYNz0zRuLHgwBU
 vzGT8s9AmHRmEdM+Wro0JdbbMMZlW3tv62JRPXa9Lbppr70ha8e/sne6ysmhAiFGRPgi
 MFqguLIlj7Hdl9i5QQyaUejM61YfJ9xh9W6CDl92YXQLDS/hAcF2Zgpf35aYTNg1U2Oj
 YqAA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+42t/Kzxv1pOhc0TCqWSxVql+ZKAC1EXLbrbiXkiBBuLd+Ln4BylyKMJ0ybj5k3Rj9kgtObpC1i08=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAwH5cYbKVY8v51jDDTMMQSgDKWT9AgPYLGt1VmSb5MvkhMist
 JoqxP/eoCKRnXMDMWUapqDZkMRrx9hswdKEX3Tw4VYW549t3z7Q06MgGwE2eN9h6sQQZlGxU+ii
 B/BD5Z+hw64EjsxW3e+OeykMb9kXCLEXnu3zOqPTOEHSyAnPGj0+4S+Zp9shJCAfpYb2jPEk=
X-Gm-Gg: Acq92OEI4+LbFD5+B5jAF1uZ0rDp9Ep8mRMZ/VxL2fJHDq9kb3dUrlONikyeoVDlYNU
 GMxwbhE8zNRvHk6GCXCiZBv/eHuQJMwJ7mAl9l+zBHW926f896vC94NiW59ysWpZfcKwts1g8HM
 dZKZTP1QbbpvGoD5I6rSBFrV0Tdm0/MQSdRouVzBKU3R+ocTi/xi/3iQ8rM7eck2KEM5DPCeLK0
 eYXBVe7fZXsI60Sr5dLaUG2K/3SmfnF6SWJAOY33FbnrLd5U7NkUu+5PtgZhpXoQ5GiObpP30fO
 RMr4V5olHYj0FRbWfi9FjE6D88YC6Z0iZxWdvifKq1H58xCnDfLm49vSf2HYRgHzFwd2jBVKJzE
 MNuRylC094j7Ep6+NuZYGuRyWIKnCtzhiZW42KOpIrA0DFK4fKFBZro7aAV8pQZjeeBO9fx8R2F
 o=
X-Received: by 2002:a05:7300:478e:b0:2dd:405f:89b3 with SMTP id
 5a478bee46e88-2f858348089mr11196206eec.0.1778602494246; 
 Tue, 12 May 2026 09:14:54 -0700 (PDT)
X-Received: by 2002:a05:7300:478e:b0:2dd:405f:89b3 with SMTP id
 5a478bee46e88-2f858348089mr11196174eec.0.1778602493662; 
 Tue, 12 May 2026 09:14:53 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8859eafcdsm23156644eec.6.2026.05.12.09.14.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 09:14:53 -0700 (PDT)
Message-ID: <f37a917a-6bbe-4321-be11-2aa59c15f85c@oss.qualcomm.com>
Date: Tue, 12 May 2026 10:14:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] accel/qaic: kcalloc + kzalloc to kzalloc
To: Rosen Penev <rosenp@gmail.com>, linux-arm-msm@vger.kernel.org
Cc: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "open list:QUALCOMM CLOUD AI (QAIC) DRIVER"
 <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260401220643.12802-1-rosenp@gmail.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260401220643.12802-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: V8lhgNpbQARqlI2XNeoDlB82k1x5j21v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE2OCBTYWx0ZWRfX8STHO4VleIn4
 IuyvPz289nCDw2Z0Bo2d1gdlEqKzO58s0MuDKKIcHoVFVId01Du55lv89SWoHS0Eglm4Bxf71vA
 IBCUKVcF52VIO1mMy/AVrdHYW0M2xIk2nl4YG4pvXRwxTOxwYQ1k4xwyHcRYxjGFhzwnyWdEr0H
 ck9VUNQBKp/nXXw7flwTut6/JAYhRplAk6cFyueL55b79SAiaPdo22qyKNgMkF/K7FSY7UMN6V4
 9NWB1XKO8uMm6WgkJNl2PvprA90eU3drUNk79mdKM62PPgSUX8batAaLXEDfRdwqi+a/HLT3ZMH
 P0eZ0x6wTh/ado325tmftJkSzRjBXmEl0UBlTTm4VdcOgqTrHSLtsZEjO8Mi7mcofeGthCFeY8K
 sFBBnZEQDEgdQuHm2UiK22UUVsieDWsOzt9jmSusbM2a9qgudlh8/4adqVkG8E4taw1xwtlNZtY
 j2ujMoc6w3bIl/kJWKg==
X-Proofpoint-GUID: V8lhgNpbQARqlI2XNeoDlB82k1x5j21v
X-Authority-Analysis: v=2.4 cv=Ebn4hvmC c=1 sm=1 tr=0 ts=6a0351ff cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1lcS69py3Ix-9TsBHUMA:9 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120168
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

On 4/1/2026 4:06 PM, Rosen Penev wrote:
> Consolidate the two-element allocation into a single allocation using a
> flexible array member. This reduces memory fragmentation and simplifies
> the error path by eliminating the need to check for allocation failure
> between the two allocations.
> 
> Add __counted_by for runtime bounds checking.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
