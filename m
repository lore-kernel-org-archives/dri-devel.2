Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250DB606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 16:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VoVcooSa;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q388VhIK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6859410E649;
	Fri, 30 Oct 2026 16:36:34 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4547D10E275
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 16:36:22 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERKSl2968098
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 16:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +c/UpPQ8lIzjUQWEHV+QPehL75Pb7DAnccEvtSYWDtA=; b=VoVcooSauuH3ZIvW
 MnUUeS9nfb2YKp6TpMsm9xkqXgC3qodGf7c1XKf2dOQkSnl3abQUDb/eLakdNpSx
 v/LNQGxueAAco44eW50PKX8wN11U9cYnTF4Dlt2FTsN57sk/QW5DNZAIS20RYCDo
 xVu9dTCZv6Aue1eKeW3lwnSchlQZSfJbk00uhq4KdWUH6Inq49ijTeuVUEDihSD2
 bZciog2Kl1ddiXbU1c1w16o1xO3Vcim3r4OmdYUU1Y8KmohKtIIOUUaBQDmMWzf1
 o6vSEiyVJlnCB5ukn+Od29ULrBk3/74vPU9cGo9A3zSAQA2gA2Mb1T+2bZCQ7/HO
 s+0Inw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qm1q8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 16:36:21 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5eab0467c89so1180459e0c.2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793378180; x=1793982980;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+c/UpPQ8lIzjUQWEHV+QPehL75Pb7DAnccEvtSYWDtA=;
 b=Q388VhIKMgTcNaAU4v+T8YS4m00otyPggBIz1tdQjohf5bWHnzN8CWnn+hshU0XxDM
 T/AgnPliWHl4wXD+gBrPzP7feVl2uY/8QaMcHYnLHUZ6Pp9l3OQE5ijgol1af+Nn05ca
 Ng3PQBtjbBOb4L4QSm/arjNivvytvM4sGrU2p9v/uXd07dos39B1nBhefpFzZ7lNLy2k
 6cl6f6W59sHDadf0uAtNHNXO77JFTFCUZPODy18PJ/L1cMh5KgdFyA+TI5lXpdw7PYDl
 IzdFaJI55RUS5UlTR53tQ42GQlUUTXKkAmy4EJafWhtIL7+A9vjglx4Kb7j+uPFsVvZU
 UMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793378180; x=1793982980;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+c/UpPQ8lIzjUQWEHV+QPehL75Pb7DAnccEvtSYWDtA=;
 b=TObwYNSK2Sz4fXLl5+cWlQ9WFKEXXugZfgCO2N+/+iWWU8sKi+HxbGd61araaVfusD
 JycHxtznYNC9utDO/q9sG9QN2Mnk9qJPEovZT0I/Rr2VmtVoFNQM7RWzxOKrpzF3i61Z
 s5mKQPCB5bWp3LTyBsQfiJ+R+FPgY6Vpu/VF+lTTP4vYCtEKk1Uj7VQKTVRKv5r1MjIi
 IAfpeif0142h84roRO7tIjKbjIKF6EdesyJDvDFEp8vaUbRXsGD9gnJOdJD/tckXfDgZ
 2NmO1XVIz1YeR33rI+gIrbtXnyZfctOHqgxc0+9iCeEO5PjpLAB2xnFY1nBNCGQImE8I
 5DuQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgeJ5+1zFpgXUP7zQr37EhGiMihYmKCxxQ6fOo8nuSO6zeu/2JIwZmj3rqqdN7TrTyHYuQqgyfZaQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJK3e3zkVjq9uJnXTkEfo9mDbiarQYGsEWTFh0drJkz30uCW0Tc
 Nx0MjPLAyofURMFxY+0UAA2nQPOjnCCqllIKFwWIXZiuVqnoMAwZ0RCXalx35oKTf5Uu5rpM6Fm
 1hqEvNg8tnOCX/BKyQ1sKLrXL7+lXD0l4JNNxwb2/R0SEQX3b3VNaRBK9RczIiBdqJIan1ADjQy
 GU546AnA==
X-Gm-Gg: AYBFou2A19eE/734R7Vh6xZVAmpZQ6V04Cc31E8QW4gagA2drz3wDnxelryXhQyy+Ar
 NK23GBD6/DEYNTOv4iHZv3Rha1gvUCGSonXYs3OKnWnlUNVX+MV8fNCtU1ri1L69MqeXfy0ZW9G
 jL8Xjt4MjI0WbxwZdN/2Znr6uhPPSZFLJEDxk0A+2nQFTD8hkTr7Ej3p67T/PqNmT3R5EL07Am2
 yrAZ8aVzhXVNygR/zOGMmjIMx5FNZ8uX6ZNe4cmpI/kj1jMHjawnAKTQfQ9LOzGgNel2ms+VDK6
 WlDtye532ioBEWZAvX6UtD0pWQjos2Oma3yfhRBxC5epMKWrz4dKS3WVH0/9IDqKisPr6oVpevq
 vxFhbaweLD3kpsrkFhUbiEcVrreyLg9RSGgpbUDnTWGklIVz1spsEsX1VU6s7fpDjgXnbFLPlD4
 sxXwWbi6Teckm0GqcaWcdAT8U=
X-Received: by 2002:a05:6122:d17:b0:5c9:a60b:e5a2 with SMTP id
 71dfb90a1353d-5ec68996340mr1704655e0c.13.1793378180525; 
 Fri, 30 Oct 2026 09:36:20 -0700 (PDT)
X-Received: by 2002:a05:6820:1612:b0:6fa:ddda:4234 with SMTP id
 006d021491bc7-714f24b9ba5mr1696887eaf.1.1793378168856; 
 Fri, 30 Oct 2026 09:36:08 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-714f30600f0sm2249728eaf.12.2026.10.30.09.36.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 09:36:08 -0700 (PDT)
Message-ID: <3f9982c9-6ec9-49b8-ba17-f7fe2616aa73@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 10:36:06 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Extend drm_ras for qaic telemetry
To: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
 riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
 rodrigo.vivi@intel.com, raag.jadav@intel.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, kuba@kernel.org, ogabbay@kernel.org,
 lizhi.hou@amd.com, karol.wachowski@linux.intel.com
Cc: carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
 youssef.abdulrahman@oss.qualcomm.com
References: <20261029203000.1763447-1-zachary.mckevitt@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261029203000.1763447-1-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2NiBTYWx0ZWRfX8BG+iXiY7qvJ
 6YLBNADq1ZT7uKr+h9RTtDlbI8uUgIoS/iH4BJuA4Hh+AbkFvQ3Y5eUh4ritO2r1F+BDY4AL2lH
 B78ChFkhMWL5gB3ceZXunYxfk7fVDoUNCH8KKk++KWT91f0mTxAbwLw3URcdncVVRcQWnmNF7sG
 qlTE2tbEcM9oqLd6N6y7iFjFuFRoeF5Le+D4JOX5PyulDwgS9SrTTafWHAXhqVejCs7hiCgH6J5
 GPnNutNFiNeUcV9e3MSv1XkwUtY/669A7KrlHFDhHHbbTrv7qWLHUq3EFTI9nzpA13Nte2JYvHM
 BeYzsDdVIQuHBMiZuj/wLgseywqeSj5tJ6u4m9w4BTrRmYCYr2Te+ZFqgDetWbl03kbJvBAxLM0
 1o3QRnLuX5T2r7rwDXq+oAcHZCoYOlcUgrGCoNCtimkGIoS7CZgi6D7SM/vBRJ8yK6E5AhTdUlg
 cOSEVdNtXV5E/ZONXBw==
X-Proofpoint-GUID: lDgsDXcQmNbA9ZSuKeGgmT6rHTfKOs6O
X-Proofpoint-ORIG-GUID: lDgsDXcQmNbA9ZSuKeGgmT6rHTfKOs6O
X-Authority-Analysis: v=2.4 cv=IumL47/g c=1 sm=1 tr=0 ts=6ae4c785 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=Dd6cMgYstlSlERSeLNcA:9 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2NiBTYWx0ZWRfX9BKKqHsXIrkP
 EYN4MQBJwJt5pkYlReJ8DIpKXEqSNtyxiei6SuBelmi4SKRvofa9+6StRvYbJpdsdq8g5TdJNAg
 STwWua451sKOrml5sy00Djqcl/QZUnQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300066
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
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/2026 2:29 PM, Zack McKevitt wrote:
> This patch series extends the drm_ras netlink interface to include a new
> node type for telemetry nodes. Telemetry nodes support two operations,
> getting and setting, and drivers may specify an optional predoit function
> to validate each operation.
> 
> Telemetry get operations take the drm_ras node id and telemetry field to
> be read and return the field's value and any status reported by the driver.
> Telemetry set operations take the node id, telemetry field, and value,
> and return only the status reported by the driver.
> 
> This extension removes the admin requirement on the list-nodes operation.
> This allows drm_ras nodes to be discovered by userspace programs for
> drivers that do not necessarily require admin privileges, like qaic.
> 
> The new drm_ras telemetry interface is implemented by the qaic driver,
> which exposes the telemetry fields to userspace and enforces filesystem-
> esque permission checks on telemetry operations in its telemetry_pre
> callback.

Rodrigo,

We are not quite to merging this yet I think, but thinking forward since 
things seem to be moving in a positive direction I don't see a drm_ras 
entry in maintainers.  I seem to recall that initially going through an 
Intel tree, but I'm guessing that it should be ok for me to take this 
series via drm-misc-next.  Hopefully that is ok with you.


