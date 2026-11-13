Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA498606E22E
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V9eK6vLR;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HqJBYcCd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4925A10E17A;
	Fri, 13 Nov 2026 17:57:12 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C015112737
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 17:57:00 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFR5dB1189947
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 17:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Fmd2nLf0haoA7oj6MYXU0Aj+BE1OMnK66p9tj6naNLk=; b=V9eK6vLRMDxX19xu
 zh6dkBNlmB0VfENHBMWLEszHKvX9eri9Gla26kaKQCnZF7TV8NsH+ktWsWeaa81P
 JqQstJD676vyyiC5LAqgy16Lfvf2JrqQWeTxXAEwSSNrtYXaiDn9nZmAT59piAl9
 v8KJWWwHMjjaxxMOISTeorSRAshUrE1tvG7XRrNZyXFxoHAZUlbeFIPdBv4mASvT
 waHKsmBj55YHJw4Una/nap7+lnifacWLjA4k3Q075k3ncuWhPjQJHQ3UfpLiklGW
 pXxLbhccY3S2QKnzZzRZtXO5ZocAZF7ZaA+25j71/m2fYOYCaRq9+DhVoYRxC1gk
 uPOk2Q==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwqufkgs2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 17:56:59 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1b3b5b49cabso1142408c88.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 09:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794592619; x=1795197419;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Fmd2nLf0haoA7oj6MYXU0Aj+BE1OMnK66p9tj6naNLk=;
 b=HqJBYcCdnFmL89kbaxfpVUkDNAsfurrVJF1KZht8DE1rm5acfxp3vp5AAckmH23jXT
 sTGOHj3su6PrmC2q1TwpW4vxEG2fiOO5mRsWi1CWJbKD/muWVaWNzS/nk02jYzYqjha/
 3G4wuPNrJ+9zyiIRK6CE9aVN81ux6Zj/Pp7skimJmLervlaqPDg0dzeQwnQ/E9dmMiO6
 C28fLVQCUB64D9TRzIyMTzH3dnQvbqVhqUYiAvZvFHjsdmd44faC9SavZVBlCgkgMDPy
 rR4fe7L6VcMJ/fhpOhTISTDzH0x0AlkNq9skjktccb5b/v+AD4ndB2XCprGvYIkjcbwG
 a2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794592619; x=1795197419;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fmd2nLf0haoA7oj6MYXU0Aj+BE1OMnK66p9tj6naNLk=;
 b=YKaaFKGfb9G44OnPrVndKlZEewgUGlu69RgY3Qt1LVurSsM3Lks7rzjlFCaHpa9DlG
 z8FQ0CFDqjnTy44lbcBPdaKeBNLiBjEuNnQiSVTTEnRruiCCn3MIJM6OmUOAPO0dRJOj
 AMH0mzC/svRT7wJuEQFLcrAIw3XM6gzXpZnS52jHXo8qgHdtJX1cX9k4Ixfd/cOiVG9C
 rNJfBDhJskkniEUfGX1FmiCZelZT1wk65yk+NDnJzt76I7+LGz7hJlPhfmTb5khf8ZGd
 hWO4FdhMHO78pLFm2d8DdxyGRWJvQsG2N8d5ASSXOkYqz+j23wsLvwobcmOBmoqfuUXy
 fHwA==
X-Forwarded-Encrypted: i=1;
 AL+hErEZMByBAItlpyNu5p32uNtuykom6a4uqIQati/uo7sk91G+ezU4hRxQn52cfe5dqF8jhNh5zLVTyVM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9PuxfDICZ1KhMqSA4YhAKkLjs8FeR7xVGB7eOvYpVzt28PfL0G
 TfWTnJM7BQ/QB+AuJPyROR7ypfy9syH4AV3xytpK/aZ9LTEC5XfdH90wOlqUflGCmaFjskZVO1r
 xkdQGEYJYRj46wBW/0AD9hXkDFLJuMZh7gKTiT7c/5ogbKhDddkVf8pEuXV+mMtjeuav9/oA=
X-Gm-Gg: AYBFou21LJ+lW66OYHSBDirGDULyjUKnVl+j4o9Ok0lsDPH+8MmN9st2W5k+P0+kKA8
 PmtNellE9rCNjbmLWFvK4QG1O2uhJHVjh/N51PVP48V0XDUhYD6y8/Jn/LC0Elm2bML2Hejfoky
 3b75zx1dreq1lKeaZnzIWNtFQ0nzIXThRgGKwi2RpbIuI2lRC6Zl7GFA9jobnl+hs7PL6VEtvcL
 8keQRXE00r8QmvSadV2f8m4EXAvkNfKx69QgOxbVFjS/3gacc/zAVlXaYy65C8UO9zwfMydQ700
 svxT4oqIs8+YL5UcYzykxOydMk8lTCPz6h40inTSHafkuKEocPFxlg7kqpCwDqFzPSPp7laUxfu
 Wh98fsWB7m2sCHi0xSxhJE1+nVr2DDSiL6IFEnZKeVvAk6aIZwUD0b72wi8ZOZzDdFl31le7Eh/
 Uusvhpp6yIDqyCb5h7T7UlXK8=
X-Received: by 2002:a05:7022:ec86:b0:16a:c6f2:60c2 with SMTP id
 a92af1059eb24-1b5030d709amr3499635c88.12.1794592619179; 
 Fri, 13 Nov 2026 09:56:59 -0800 (PST)
X-Received: by 2002:a05:7022:ec86:b0:16a:c6f2:60c2 with SMTP id
 a92af1059eb24-1b5030d709amr3499614c88.12.1794592618530; 
 Fri, 13 Nov 2026 09:56:58 -0800 (PST)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37956bb0919sm8891447eec.29.2026.11.13.09.56.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 09:56:57 -0800 (PST)
Message-ID: <df3a9511-a17b-45d6-b048-9cceaffe6a8b@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 10:56:56 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] accel/qaic: Add callbacks for DRM RAS netlink
 telemetry
To: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
 rodrigo.vivi@intel.com, raag.jadav@intel.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, kuba@kernel.org, ogabbay@kernel.org,
 lizhi.hou@amd.com, karol.wachowski@linux.intel.com
Cc: carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
 youssef.abdulrahman@oss.qualcomm.com
References: <20261106181225.3333260-1-zachary.mckevitt@oss.qualcomm.com>
 <20261106181225.3333260-4-zachary.mckevitt@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261106181225.3333260-4-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4odi73iufmBT8hGC9gqMCn9Y7xW6gkSZ
X-Proofpoint-ORIG-GUID: 4odi73iufmBT8hGC9gqMCn9Y7xW6gkSZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3MSBTYWx0ZWRfXzZqG4i36+/Yl
 WE/JDirwb+euC5RdKlrWdHKXDK/VzN9CVb930dkoPiZNWnRKon3KY/fUCiLQmMIgDjcD4zNGL3D
 OPkixqCoHwm3UGJFKjVQbnZQj3aWWnTehvgFWXRi2l/VMr3Ni2EZQNKm3tX/GhOkAwqhcCW9HEJ
 A2SvVxaARQe1l3/zA1ksqCeVeKDK0Me9OSJGp2jWjkRmGJ97+pW362lxLkEorKgawLgdks4r7bQ
 Wer6cB7b+yWNlFvmvNvQdicTUUf1XcJh/W/ErNnq6q38PkmJ2RRypIhjBK/5A3fMSjXdN22QbN7
 R5K4iUtlUE3CLnxqq0fMxf76DMch78AK2mCuHBoBLhxEI6Xm7kNlMdL7KTNHUWzOrwsngTZmw2H
 Suu9G2wXMLRB004HPPdP6TE2vrFyqd/nQgry4E38C87GMgJXuDcjXZQJxbn6c8bQ1/JY8QV8xFj
 bkanIRD3vkqHnf4+aQg==
X-Authority-Analysis: v=2.4 cv=XZocX455 c=1 sm=1 tr=0 ts=6af74f6b cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=CNMjiE_s7LF6lbcXpzMA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3MSBTYWx0ZWRfX0Gxtj1aZB+dN
 /kyD/ItEW6fYzfzt+sexA5QqnGKLfYtbnfvYsUwWw+z/AYF/QaarEHe5OPfUaLMU0mZNG2n+GSM
 hvei2cwrJCO9w2ZBAASOhE390QQRJc8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130071
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

On 11/6/2026 11:12 AM, Zack McKevitt wrote:
> Use the DRM RAS netlink infrastructure to perform device telemetry.
> During PCI probe, create a DRM RAS node with DRM_RAS_NODE_TYPE_TELEMETRY
> type and add callbacks to telemetry_request for read and write operations.
> 
> Co-developed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
> Signed-off-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
> Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
