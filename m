Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D0BC4450A
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 18:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5A4B10E0B0;
	Tue, 14 Jul 2026 18:07:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UytwnRh6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OrUtmDx+";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFF9B10E0A8
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 18:07:50 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EG75Ze1091275
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 18:07:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2cKztgpSNjz3WKUCSrKkFj0FRV10LmHOvE5zYzFACW8=; b=UytwnRh6KqgcC0lX
 KVGpRsB9qhja5Pg/BP9NgoFaytz8mPapShHcJlC0SRunomtbZiZpaD4IHreOwo9o
 TX0/eecIZhw3bn/YXX03e4wgmUtBTnoanopd8p7ypsq3nVvGwC4I1FVAUK+5kGe8
 QDZEebQ/R31Om/+TnVNu6vaw5sQqfIa/HM6vsR3jU6t6FEZgVr9fqHkekbK7XQqA
 ZPtNErVYUgcUyekFBlev86QhT//iQuEz9ppHr2mZqmTnlamyDYfFxwKHUHB6G7vV
 4JWYFP0NT3idKhWnscKE12eqlOOud7vW2C9D0WCrFIjpjZB3Lj5bq2FxiuMD0rQF
 3WuzFA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdgudjgcr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 18:07:49 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8f0f45415cfso23682226d6.2
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 11:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784052469; x=1784657269;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2cKztgpSNjz3WKUCSrKkFj0FRV10LmHOvE5zYzFACW8=;
 b=OrUtmDx+hgikPTdUWVTV/eFu5Tcmo8vew8v6RdPirEY44z+ZN2T0NWu5e4UlVC0PaP
 oG3rBoZYa3i8/CjAzrTMGsxQa6ce7JIaz6YwcPKS8w6Lay7+vFVy8mxyQprEqhVZF/H0
 bU0qW/i46eDasfDn4S9aSQKIvS9nXradjksHcfOA91rAFnkdvfrqaIR7JixfNHIMqGfo
 FRSyADZIaGGv9vz6Wi8WOKGTi/0rmFCaNciUWjzF6cVeHCgF+fzuwfeZcQkBUFDLdri6
 3RwQ3JMrfOYk4HujNu36pxAOPj65zl63DSZ3DONRHjZ6KJ32cU9GtgzGek6EDeGkPrXr
 o/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784052469; x=1784657269;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2cKztgpSNjz3WKUCSrKkFj0FRV10LmHOvE5zYzFACW8=;
 b=sKquEs8HPT/cupnH4jownuw3w65/yiY41nqyFx6p6HHw2PV2nxDV0cBh78B+0Nt+3/
 Gtjt0hN/YOnSzmpFzZgOWkLd/1G8R4S/70XSLwvlLLVtoXaDNk93XK/n4UxXiCSHoavZ
 uQIZe9clvFZ5NaQFTEGC/Ngb4YPmSnuNso9zJ/84QcB+OOwo7c38KiUdgZwTuhV4WFbj
 FmN9jJ6oMXewzOE7kOKN1+pBWrfKS9MXkzXIV96TeyYLFSB/gbUNjwoLZvlaBI4BhzZ8
 s8sqM/ggVxqt7OgM5XzeSR0V41EXrMdml/rMadlbs19l7v1obC9Fb1OJXDZsqAPIYzpq
 46hw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp4XHh1EXmsMVmgzeuBkVsQOZCMdzWT5OPwOGcx857DnpOfEPqyeK64YRj5KfwJVjLsvn0jnlI6v5g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx9rAqho1pZfcYohzfvyGQOtJfggZ/mNha5dlDPDQNrsB43SMb7
 AlGqwe9VfXXxrB1GVB4gFfe+y/AIGACV0rjDDGzOhZE/f984+HuwjFv1YzGLQHUyMpxtUIxOO8W
 5ExrHlPJpJAcnBTV4xlp0sVL3t94v6UVcrjtmPKip/6aVXNTDKksj6qBqsLI/cTYHiUCAKKM=
X-Gm-Gg: AfdE7clDIBPIGto3m/ahNuVwdq3mR/ewZg7Rvx1bkMo1Rm3mE5Fn+AmzRhYeXGMqY/4
 M1fIpXYWxFWkPDUtKi/hfJ39X0ta5DJEDG8rsJYPYlPUTQY3K+Zv+qUTNQbTXu/fA9RymOEhImA
 sz/2OBOflfcPyYbbEMaG8WAdYZUcEsyFFH12yLu3cS8e624nywjuMILnPWHnY9qxbslUgCy1fR1
 pJN/eFd3zMo7cACgihIqTaQ8zgusYUgdGa8s5eUyLxYfDC0fn/W2XFYh9nE/5yIJid9cfPtjMJk
 cdAQaQ9vKeQb7riqcVDmpDBP7grtHRgCH90dnTFji2mauqpgV43tiOnPcR0NA2CRMN2P1dOGGJG
 XiFwO2iBKTslUQSy1oLz5lDdT9hw1Vi3m/d7j6248kOoCAkYKwz4W/1mgOEjpucVB7A==
X-Received: by 2002:a05:620a:2601:b0:92e:e314:c9ca with SMTP id
 af79cd13be357-92ef2c1fa96mr1459203685a.52.1784052468811; 
 Tue, 14 Jul 2026 11:07:48 -0700 (PDT)
X-Received: by 2002:a05:620a:2601:b0:92e:e314:c9ca with SMTP id
 af79cd13be357-92ef2c1fa96mr1459196685a.52.1784052468350; 
 Tue, 14 Jul 2026 11:07:48 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930759c63fbsm465448885a.22.2026.07.14.11.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 11:07:47 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org,
 Sumit Garg <sumit.garg@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
 mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
 mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
 jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
In-Reply-To: <20260702115835.167602-1-sumit.garg@kernel.org>
References: <20260702115835.167602-1-sumit.garg@kernel.org>
Subject: Re: (subset) [PATCH v9 00/14] firmware: qcom: Add OP-TEE PAS
 service support
Message-Id: <178405246411.4102418.8979771009872296240.b4-ty@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 11:07:44 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: 0DyLAo8ucDNZVKFs5N59xJnr_yBaLiAJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE4NyBTYWx0ZWRfX88JsP//a5nn+
 /E4tHK2+8BFVey+tmrOBxrhQyq4IGWKf0DyIP3PME89Yk92FA6ekxwAoEJ+loMXmIX+Zi5/QeRi
 RxcNnrnm5HwT0C9ccilcBQj2N06ZwHqZfgnzAnACkpwTPplAy8Ma77qEQgWkVriiUjczJ6j+9Yh
 EslLP3Xiy1k4irCJ5ymVc7I1HVdIR1iu2Y8RHLTKVQP6UcQc9Ul05/TobQcbo1lQQmFDX2bXgIL
 D5bHP1jnTq0IvzfDnf1ip0zWOMK06trAxIRNiv6aQLEew3pdR+8WvUgviDdw2HFRW8ippNka7HL
 OurkqBFm63tZ2bF5lo0+IKo5sGomWzeoQacyV6iFStV2iQJRj4ffhmgdSe/mALtUEsx3JYlzTNs
 tv2Py1pXoGze7wIyzDxZ3YVOCVIxUMg8Lxvfv4y0j7YzBpgXlQKIvHggke8oJUl3MVt8YVTzUmO
 /i/7j7fQ13MzVQ5kfcg==
X-Authority-Analysis: v=2.4 cv=T/O8ifKQ c=1 sm=1 tr=0 ts=6a567af5 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=50BX1_4M625rkW4sIQwA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE4NyBTYWx0ZWRfX5bROooK5Yval
 TkDfcQ0QFd7wCbqpDI+4g0IIkg3CQ6i0nkw+LoI/b7ipafzbZ/v9qKxbn6ZrvBvqjGo3p99Rfte
 2ptIAank2Qrs2bKYteesspY3oTOHwho=
X-Proofpoint-ORIG-GUID: 0DyLAo8ucDNZVKFs5N59xJnr_yBaLiAJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1011 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140187
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


On Thu, 02 Jul 2026 17:28:16 +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Qcom platforms has the legacy of using non-standard SCM calls
> splintered over the various kernel drivers. These SCM calls aren't
> compliant with the standard SMC calling conventions which is a
> prerequisite to enable migration to the FF-A specifications from Arm.
> 
> [...]

Applied, thanks!

[12/14] wifi: ath12k: Switch to generic PAS TZ APIs
        commit: d418509383b0c884b70814ae85d3ef105a63b940

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>

