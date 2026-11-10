Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0E160A2600
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 10:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mUkDTENG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DZFRxdF5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EEC210E0B4;
	Tue, 10 Nov 2026 10:55:08 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE8AC10E0B4
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 10:54:56 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA8Z4cp3849683
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 10:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /GvGp0ikRhYCrmCcfVEdjux6pBM8MsB+KXbne/7lAoM=; b=mUkDTENGYogoUsvm
 c5dhKSLCd9QM91OJxfv7P/41BMyzplzxuqEIQ4Jwfu5jYTWHF7U1Al+4NPkDOMmz
 iga3w6m/DQz9x05Hu9jEWUPSVj0DQ+pww6XjtaK4BOzQJUUQzeMDbkvSWP1xCfQb
 0cmmsd+uwojsqcaxuywdQYFC3RKSaQSJySWIjUGOp0+hQz/+wGFAqiNu1IAv2scU
 DT56nbSTh7LM7nsybPDfJ7QOz1+gsMP0gKCTjtD8FAsMH8DKtMf/47ypSaKhclJ6
 Ld69AdFzgun8lHVDOU8Z/NTQ4NFao5unLvq/FfX3ryDlH1sx3lKBGP4vLqhuDSO1
 JmnEcA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huyvwgfyf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 10:54:56 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cdaf2073b0cso1146669a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 02:54:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794308096; cv=none;
 d=google.com; s=arc-20260327;
 b=sM2FZAV9ZH3g2GzbM73ifH7wFaLW7GGycjyJyzxDH7jkw0MvICov4QsOvACMupmmrk
 ID6wW6W4cyB5h1IMODCGuH/ZpX6Z2clx5TD8gCWVIWzgrvhalYtmzp18Rj20XDEFTdQu
 Sdm98fFbY5Jxwz/eyue9LPCYWWDP4j8fqVO2Oy59GKPP0B6RRWhzup/z2Ay2IhXLZNgl
 Duip14SRNiAgDNaRfU17dfLnSJw8Z/3RiDKdFlkknRCMcm5w9twGI20baMa/DnMb3o09
 ca3q0cTsgKT7a9NRIZ/XnP4fw/dlfVPA6YbCewFRnQcEVlZOqcJ0LWHbtEHrQTKrWUkc
 hpPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/GvGp0ikRhYCrmCcfVEdjux6pBM8MsB+KXbne/7lAoM=;
 fh=uapbSZ+4te5wm8eJC4NB04P+OJFIxprOnONBf8yhZXc=;
 b=KywRIS1KY7Ebc8Dw6GszTifMUPjJsJUXQQfPcjPEIrX41C23/KUsM4EIc4ll2vpw7M
 q+XQ+/Irf35HpSiqxKsuxo7HJMenwfZ+zveWlS0g+seWc4U4euvmDQwNZZJWM/hmQx6z
 elIwn3nW2AOpAvMNlccf3Kq6ssBBqH/31XERCk0UvaNrFM6c0Pl2UpON2ZW/HRTBYok4
 QoctlyVJdBwKv+aW/xbxMzY/cr2x89QW3WuavPgnD64J5ZvV3bJOjollEai9jTod7Y0e
 PKQQtPQVSI/d+hXRfS8LRXwoMl8U4/l3eQByqHHqngKGHbmLJj2cnIADHd3z4axAJcg0
 JT9g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794308096; x=1794912896;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/GvGp0ikRhYCrmCcfVEdjux6pBM8MsB+KXbne/7lAoM=;
 b=DZFRxdF5DGKvzCNQM6bE8kgcsj60zm9k+bBfgC7X+ESG+dTSw43Y4Nxm+VflBvsHsp
 td8Ansm28pLDtEOZ3NANbvd1qCZqyN4amTUzwlZwJjHTWkc+AJloRM1mUCGsVo055Lbc
 3+R7NW8dW+xAODoS8PZ3Vj7CM+X1UpX4GILCPSeWxV/vUX29lzM8/W7/BLhIl2wX5vK5
 2C4+uBVc7/5MBp1l8SFsnGzZfq9KpMvp28TXk+j2scabYZVkFcMecapegor17oa/bj7Y
 8YUefhCK8X/qDQMQRyuHCrYpUmOwQIW8+Pmzv+o5hUhjQqydssdb2nXLfFMiHcnz30DM
 30RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794308096; x=1794912896;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/GvGp0ikRhYCrmCcfVEdjux6pBM8MsB+KXbne/7lAoM=;
 b=VwF+sx7tuwmXupGYgQpqo7w9i4IjlhMaSZsRfagpKz1LRCqOne63XugenPevaxxLkM
 HCPuWAz+9yAeELmwy6UwP5MnBTkp/MSN28YC2NirEL08TdtQuBLlzsXDFd5mKf+WyRbw
 lsiuQEIvXRXUT3zJeG7l1I5K291Vjyq/tRsqUupOsGhDV4q2AiKf6zfcXDuo7ZHi1FCs
 EUVnDmwMgJhSHLdJH/Sa/qbFUrrWuimLfEWprqz2CDsByPtjY4Ni7dmwZ6mHGdZA9tbf
 6+FuKK001UBmR0KECVDN0r/TPdSfpqfrfW1JjZMjc5JzuP0wGV9eeun7eLsqN5ht+aqs
 w/5g==
X-Forwarded-Encrypted: i=1;
 AL+hErGnGNV8WF23JDG5bnSH7r9xEM3bXJUtQWBBLsOwTvWepqS09UEawaGl5e5ImyzRzNNTwLr07HfEBgc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/2dtQVioMwqOs6bHmdgprqOgbvggzU5r78tyLq48T/B7BO4vdG
 R7+wm2bB1gBohRiExxTr9YkooB0adimXmLN3XIhhlNvntaw5JtF7WbLTN89e7QmyGyIvZFmkyLj
 T1xjsgUdJWm5+t6f82AGKKMLsBkWVNcboqQ0sG/dFRiPFiH/6Xnc96IJ5Y/EF2jh/lmsjqJ++mr
 vpKcrSzsQ14opCSr0yRT1HmWFtSfWdNgkDiWU5kpX7rorJog==
X-Gm-Gg: AYBFou384xhdBwkIg+rs0Ykc/t8l97TlAEke0eaWWyDbUmE4x4kmw8initnMgb/psO5
 FJjin2spVR7wg4NLIMN8OA3tMzFPYSGqNlbCNf9XjJ2M1G4Rb8/BC77IAvMHQ99Y7kXtT2twb0i
 ulQMwSYMJyQheO1DGxMKVXqIcejA2EV0epnTR4RZKQJfpsag6AeBQR4LBh1w==
X-Received: by 2002:a17:90a:e7d0:b0:3a8:5fd6:cb6 with SMTP id
 98e67ed59e1d1-3b166a5fb0bmr2419108a91.0.1794308095857; 
 Tue, 10 Nov 2026 02:54:55 -0800 (PST)
X-Received: by 2002:a17:90a:e7d0:b0:3a8:5fd6:cb6 with SMTP id
 98e67ed59e1d1-3b166a5fb0bmr2419092a91.0.1794308095395; Tue, 10 Nov 2026
 02:54:55 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261101082307.151957-1-gahing@gahingwoo.com>
 <6777074.j6PcuT4dK6@diego>
In-Reply-To: <6777074.j6PcuT4dK6@diego>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 11:54:43 +0100
X-Gm-Features: AclHuK_tfQs_KED6YGEFdDQzYeq154VOUvxzh1aCGwTqlSdSoloobK9cAe7e-pc
Message-ID: <CAPx+jO_gRtipR7iuh0D7G2Wi25GZoqFD1JHVbJNmhd1UyC3Bmg@mail.gmail.com>
Subject: Re: [PATCH v15 00/15] accel/rocket: RK3576 NPU (RKNN) enablement
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, zhangqing@rock-chips.com, royalnet026@gmail.com,
 abel.vesa@oss.qualcomm.com, sebastian.reichel@collabora.com,
 sidong.yang@furiosa.ai, u.kleine-koenig@baylibre.com,
 chaoyi.chen@rock-chips.com, diederik@cknow-tech.com,
 alchark@flipper.net, leonard@lausen.nl, jeff.hugo@oss.qualcomm.com,
 rfoss@kernel.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: vRiNBVLGi_Dh5l1N1u8xMezBGtaBo-hV
X-Proofpoint-ORIG-GUID: vRiNBVLGi_Dh5l1N1u8xMezBGtaBo-hV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0MyBTYWx0ZWRfXyiV1HkqKW36P
 oJFNpNrhzoCpw0qTLng5k8LD0kUd8jYvlSjpaZNou4cMXSRoAtfmnJlbn4d1v18a6gaEkRAWucc
 JOOERqPoFJYPGlXa9+KsrEoi4kWXkFo=
X-Authority-Analysis: v=2.4 cv=NNpAaE6g c=1 sm=1 tr=0 ts=6af2f800 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=HKy5YsogUvdA2KhsgGYA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0MyBTYWx0ZWRfXyfe6xiiBL+Tx
 6561mkgjmN9hUAUswdcHaZMDZAsq0VQ09QV1+MQOQbiQFR2niiSuVY/DoWxj8AEXDqAKMcyl9q4
 z5EXCaLXIc3stWbPhmfxwUlGBv0GaE/DaXiTZQ+djGxxD4Rlvr4OObDRcx0TXt6CZyMFAT6KvjF
 UlQXElR5BadFJAWQT3Lyq0JNaGI58lY+5/HBqW5woQijswDV86tDy57IahlkjqvrPYuxGv1+qIA
 eD3EriPtJ3k8uOBYTu37gGpDhuSIAqTAjYOArUDccK8vDcR6s6DS6tK6SdPRo5+zysWhEqgjXOX
 /0jsngk5xTdpDeRMpBZLdZArFOTMj7snaEh6u8iwQn/ey2sMXsNTYDEFIfNmuF+NWz0ItJBj+4m
 bbGLav6qQCgRaIPf/SakEIXh9hsNLwdeScwlHWZsRSqKp9JBxGyh8NTR642JWJVdjH2iEPoQEWa
 +pJHHMfvx3o80X77y1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100043
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 3, 2026 at 11:39=E2=80=AFPM Heiko St=C3=BCbner <heiko@sntech.de=
> wrote:
>
> Hi Ulf,
>
> Am Sonntag, 1. November 2026, 09:22:52 Mitteleurop=C3=A4ische Normalzeit =
schrieb Jiaxing Hu:
> > Ulf offered to take 7, 9 and 10.
>
> I've now looked at the patches in question and they do look good to go.
> So it would be nice, if you could pick those up, when you have a minute :=
-)
>
> Thanks a lot
> Heiko
>
>

Patch 7, 9 and 10 applied for next, thanks!

Kind regards
Uffe
