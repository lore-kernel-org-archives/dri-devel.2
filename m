Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F82AC79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6937810E7EE;
	Mon,  7 Sep 2026 13:03:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iZhfuJtg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dd+MHzbM";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2D2310E7EE
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:03:51 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687AvM4p496217
 for <dri-devel@lists.freedesktop.org>; Mon, 7 Sep 2026 13:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 49eWOMRTz8b/nRYqL1sZZ5PDoGraU/KbXkHhAHawsZg=; b=iZhfuJtghjqe30Sf
 NkPTAUBQ1azhCIPyIU5kPudBwzazGbAncmU4S4LrH8geBYwE0YhRSXAjC0tMKESg
 zLf7MAxp19AskYp8Fk1L5z8XqmOA7DWwLk4AdQgMEwGgyA84/+ql3++AdFRVFtbw
 pz+p6pmLxUohExO7iuhq2PK/YQuV9D9WZV9YloS+NR1jTpCCl3nOIL6m/mr9PzM0
 eYDQrgca0H7vjbE6va5X/ktVR2tsNH0WEC1Z6lZ7R3/E6qp0TN7+5s9UBtNbtZhr
 oFG2UFsb4VON8aT24ugpNkcToXQM3bqO964+SREpDSqBrZI6+zsJKBaURmO+7GhB
 3+6OmQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghuyk8dsr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 13:03:50 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5c5db8b6d03so1212056e0c.1
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 06:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788786229; x=1789391029;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=49eWOMRTz8b/nRYqL1sZZ5PDoGraU/KbXkHhAHawsZg=;
 b=dd+MHzbMi+hqMpltAWoAN+yFw1fa1cw6MoG0K27wFzjONbYH4MmvmHT/2WgVrvuwBQ
 DzYS+c4wSBWj6kzPEfyMJWzQjMpYoz626+25ugo1RA6u6lcekRfL0IAT3VuAMV4vrxnE
 vInOYjQp+D93Ce9oXK1lLHhOUDKNR5rcefLtfW7TFaBhYdZO16kZGYz2KwkrCXmJO3Ng
 +LjVabH41DUm1+2Dlpc4pgNz/5idsEmqLzB+c6iytqJDe/fzErlVfji397M/TtI7ICmI
 gaEJ6uN1TK8s8T/zXl3sPJoM/b08U6vrK6Ky9By09araL4LJMy3NKkBMGepQAQdm/z96
 oxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788786229; x=1789391029;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=49eWOMRTz8b/nRYqL1sZZ5PDoGraU/KbXkHhAHawsZg=;
 b=qJXO+C3drWmfeSqLiGqNJQRfi5S8srOgrLWt5Boly5o0nYYJe21YMLqO9LcRN3Go8S
 2+07TPX1OmBe9PsKCHcfirAOr4JUP7qt0Kxzr7XfhBRFRfEYacIl9Xnq+fxiW0zon4iT
 ByYkZWUO6nA0a6W9ncFB9RCElfW5Q449eMS01Pszw+9DqFbjI4vi2cBOfFh3CBUeSFbo
 mQVA1S9NBe8ZlK1ie3Izhp3l/Ze8tXHdA2O5svwJflr/sMuuz0TY3Fmgl00ykelnjAs6
 Jy6GTGCzD9nB5cwj5Tlgn2fxtGLerZDEjKx7VG1okH/xyraeOqmzNleGcF8IJSh3m62c
 abdQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxuqiDM6yfQgCEKfCeemXmG5iyJYMjk07JRHK3jEtjDdUf2HxTok3TrnLtqOgfkTp3Dtj4Y1Qyk1kk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k4Zdn21Hftkb2qAIDXUIz0lkYZpmQR1IRsAEWWLRwKkNsMMTXn
 5nkSN1l+jHkjzUDjyqbxWGTrzGpqeD1gVPuYFD5nL65q96s7HdSwBhGezVSIJEIkL9i61tc8io9
 rz11wCJffT0sAF0/1pupItTg0uLBFroKxoZMfdCkYtFoybTWBdezNxQTiiHyHilkHDEP/Zvo=
X-Gm-Gg: AYBFou337T6QKoi9M5WRKlIM7bnUUBbI75dS7AEGdMNsmgDpq/uwY8GIOCC291NDNYP
 tyrFSsOa7uvhvUmp2O1ZlH70EH9p6CSXMrR0QZRV4EFMW18fLw71K11Or0c8nIMA9I7EPKpq7Es
 P8wC0pUUJtyEAhVyzoEhaWnitIocUyVpO3LUjlY/b462EoPFLqnuY1Z3XJ/rTOwEeayon6HaR5R
 C9MWFHkSRCf+8OCHua7CDy7ea5exDCtrig3urvERUraFvvfy/fRh+CstmxWIdL82IXzLQmeimRJ
 sm/3y3nV0gUeOqUfKTIAntz2uqy1GGMtN+t6ImsADyveGWUrDg8HkZFUPZzRG9bgZa3R0xhxs+B
 8MVwp9ObnZzHd/brAh8gr0Cn0Lu2e
X-Received: by 2002:a05:6122:4f83:b0:5a1:fbbd:6bd0 with SMTP id
 71dfb90a1353d-5c7ed45ea59mr9264671e0c.5.1788786229406; 
 Mon, 07 Sep 2026 06:03:49 -0700 (PDT)
X-Received: by 2002:a05:6122:4f83:b0:5a1:fbbd:6bd0 with SMTP id
 71dfb90a1353d-5c7ed45ea59mr9264575e0c.5.1788786228908; 
 Mon, 07 Sep 2026 06:03:48 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee80eda4sm388303115e9.15.2026.09.07.06.03.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 06:03:48 -0700 (PDT)
Message-ID: <6a485a80-cf23-40ba-b385-fd35cf0e9888@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 15:03:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/DO NOT MERGE 08/12] drm/msm/hdmi: Add support for PM
 OPP table
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org, vkoul@kernel.org,
 robh@kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
References: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
 <20260828-drm-msm-hdmi-eliza-v1-8-67843277de17@oss.qualcomm.com>
 <20260828141602.211751F000E9@smtp.kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260828141602.211751F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE0NCBTYWx0ZWRfX1VJt7BgSFnhI
 mSVH12rTdk66RrfS2dN92GeHFccxJhYvHd/pP00koLAwwy37iGfnmOVkoMhevm+vVxA4wjAjAyB
 T2yaaDALCTIdonMGH5S9Dyjubsjy/cw=
X-Proofpoint-GUID: fBRWB-y6y_z076jw51QdWbk-dOjJzm-_
X-Authority-Analysis: v=2.4 cv=ObSoyBTY c=1 sm=1 tr=0 ts=6a9eb636 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=3ryqjR-gYcLxyyiNjjkA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-ORIG-GUID: fBRWB-y6y_z076jw51QdWbk-dOjJzm-_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE0NCBTYWx0ZWRfXx5VZOG0JYPCA
 kDSuaPGBrgOf6DUvYtLgz1C1X+JugBNLb9nMGCtXMHfUltbeK2xomCwOAf/KsCDYTDQgjFWE0yY
 UyjsWdED5HdRfEXsWc+Y+15C1fmAQXQ6sXW24aqO3pJR2V5DolDZaJALYTbeOhE+B88PgsFaK3d
 ZsVU+TtcT90OsKTAtAUXPIMlqyAbsn7aa8b29XxyASYlgp7RDxJBWVu14ZNXJEIO26roOhLp9X5
 ih22vbLRU4aQy7Zh1xHThC6mPw5rmwTsDEFAPtkrW9j6M3pqEX+aY+PYH6nc8IvVN01+S9bFDaP
 4Op0L08QYMK2nzjWc26oIYt8GtUwyqSmc6EuzE4h3cs5btBUBEH8jwVY5QFr4fo68Ze+RQvtZJU
 5Yp/7MIy1TUbyEhJL+/7k7Z08XZfi8I8L0CyTRuS1hD0pns0IKWvGSUNaF28zQOm15uqVtRfhUz
 n4T19VYDXn2+43TjhnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070144
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

On 28/08/2026 16:16, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Unconditional call to `devm_pm_opp_set_clkname()` causes probe failure on platforms without the optional "extp" clock.

Ack

> - [Medium] Memory and reference leak of `hdmi->next_bridge` on error paths in probe due to bypassed cleanup.
> --

Ack


Best regards,
Krzysztof
