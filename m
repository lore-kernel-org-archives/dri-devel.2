Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830FBC982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 08:49:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3A5C10E2FC;
	Wed, 23 Sep 2026 08:49:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jH8Qmg9y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JqQClWFi";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4755110E2FC
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:49:48 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N8JdjP1387507
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 utlvqtMchWtCC+XcUEgzWRs3KfFgniwcYifuRa3zTB8=; b=jH8Qmg9ya8OiyBxg
 TzpLC3x0KbJQYjHG2zXS7IbFbTX3tBWK+i4/99z1j2Wo9Laz45fPMQEnL4azu5t0
 gxGpTh9qFHpbLXd1WfgXC3P/DR7VwBE/G/nqtx2d2nZhGyK5XwNyRaDHAXe0b/wY
 3Hi0AXrs9xIk9YOowArVEnpqSzbTCegrkDPfLPVCgTvrJ8Ng4sfLdAngFo5mPZgn
 OGSDBj0bHvni9AZWiTWIY7Lh1Qc2d3P3LSv34Gpt7SEdOT3Buj44WY8FlHpt8Z6/
 GBX4AT9SkTTwmD/ViN3CRYnUc6l6wKSPKZSC2yfdE56rbSGuAMu3cAZz1o540HIU
 BE3F8A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guyma2y8b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:49:47 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9103db79014so1465066d6.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 01:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790153387; x=1790758187;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=utlvqtMchWtCC+XcUEgzWRs3KfFgniwcYifuRa3zTB8=;
 b=JqQClWFiL0k0ZeVCgaIoDmdkow6i+b0ygOfPkSL8nKEeO0vE/tJfKMrA55sQkv2YRQ
 WOb37GZE6IND7IcwdYCWWqNnpHtyO9Xmg8pDhhf3PkoFnSsJP8ohdlq9EV2WUMTC1you
 ApF/GXp+DNkOuV8Wy8qkoUFdyHfSwL5AjMkpgXds1ZllTr0ZWBScreGdtJ9T3+bmttGC
 2rZ3Y8nRuXsbVGW2ah9pCvkWTfxxqNau9DXB3546uK3hK9uxrv6KjNrR+ZFSkZIyX1Px
 kmM1g9zF4OnkSd5kHm71ww0Zk+kFBJYCPx5XZ5mUxU0spZiSZM1qQgS52IBWDj6QW62g
 ngag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790153387; x=1790758187;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=utlvqtMchWtCC+XcUEgzWRs3KfFgniwcYifuRa3zTB8=;
 b=OKU/ob/dtL0jPfZOdttwlmq4TB4JPNPWs26Q6Z9+1Jdn8Aif0dB8NOaubJ7UmP0aRP
 RSAmpy6XHRKs/X2oD13/lAPku8rPNaBz4e7gp7mnhJgNBuob5qpujcNgQRsXu78r7XMh
 Ylu9SdU3Bk7RuI+4otzbJ/1ot+/TOI0uhV6Jwy2hIJScOu5LqkBbSwzif5pZz059Oa+X
 84FGS5rsffIXchNSHdcwSOfVOCcyIxWiELO6uxAoNNGkPkBLg5F8joWbSt7dI29SGTBf
 +NmzsQobLrSJ41k8Z+biv270+5s6DWzygPW+vvVtJVk0zROGqhAkMiDvmlriMWmokTaa
 mj5g==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0b0m8O0cKRVzWzfuSiEUsYVjP0O6VazW+9nupZ2u86TWDl/G8YxX9OFhj8xaYpjYtqXtDi/jNXZ0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n1wjxwqMY2PNoGTM/8BOru9YWzcpIFg7WItq5kudF52JrTZFy3
 7E3qIGYZQN4SwnrljlgU+Sw+Pnli9Z0/ufvqebVXvNksnWmeLIZI6XYHKXm4kzD3loivgUlk85D
 QW1hycb8g/5gWS7GbM8u2cVE8yz2EMLFUDZesU7qN0NIHyvMMfB46y7WQsTl9B6LwsRuCzDs=
X-Gm-Gg: AYBFou0BEUhhQxdAuTIp78LOcMMEnHqYHTNAYpjjVug+t5B5zS8Vg7dmdvFphAIdZ6L
 OH4wM/a2AtEfskHpZDWFfHrt5IZeREg9o3oJrQeFh+3kdauNwpFLhrkXlyhoVs/ofUauUbX5oAz
 t7w2WTMp+0/qldS03D3fw1NPixKQC06+REWR8JZm6VlfBgwUbmTDnrrWfLf39fTQl+Fk+GmiKiD
 cVM5TjmmSb5U8o/JSIQlk2PzcJ0gsxOak7+jOyudPKUzlw+4pKJ5RRH73yviFBtiOr+AOBJc3uo
 jmIwmjdhTwf+7vSsNb65Z7MGdn1UvprNHoEnAIsl8l9vYUR2Z7llbWpugD4XxfTLyhR9YLjwnsy
 Xxly9ZueeLTDyJzORVKbLuVxYprXDdxYf
X-Received: by 2002:a05:6214:1307:b0:90e:8d21:714 with SMTP id
 6a1803df08f44-9140c3d4acdmr34040206d6.2.1790153386711; 
 Wed, 23 Sep 2026 01:49:46 -0700 (PDT)
X-Received: by 2002:a05:6214:1307:b0:90e:8d21:714 with SMTP id
 6a1803df08f44-9140c3d4acdmr34039986d6.2.1790153386272; 
 Wed, 23 Sep 2026 01:49:46 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aab37eaab7sm1171451a12.4.2026.09.23.01.49.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 01:49:45 -0700 (PDT)
Message-ID: <bac16296-42ee-4b18-b605-9ed178210f4e@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 10:49:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: fastrpc: Don't fail probe when the SDSP memory
 assign fails
To: david@ixit.cz, Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Xingjing Deng <micro6947@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260923-fastrpc-fail-slow-v1-1-f3f6fabba6e3@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260923-fastrpc-fail-slow-v1-1-f3f6fabba6e3@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ZfIDfOS_Yv57Pf1THTLbfyBWgr40O-AO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzNSBTYWx0ZWRfX5XXUXpi2/hrB
 ejlSs0iWkaAhpKjn7CfDnMJ+o/T/qK5BQBxsYnn8kgxH2vLtVpngfph/I3kcGiy90btTZZVRDXz
 johbiuruY6Cr/qCwLhcxxIB/zlSRfec=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzNSBTYWx0ZWRfXzvU5RO+aHeR8
 liGggqrshCv2VWPaIveJrAdKsOLw/FkXdKpA5/c6prhkn89hLsVSPGW3NaPVYpsxAkiciCT2Jm+
 JaBHsPE0CUz66GzphpQcVwXC3ffP8ojBVQJKPtA85HLLRVnm7+R627ZyusY7Lc/NtuNBmIBoFV4
 yBI3chaWiJ542QrPuF91pGE3VNF08R0Dw7RTTVVEYTJ+k1/bl7f+oWjymUDW4zPzlY4HpAWK2VT
 Q0PSFuF7g4df6eQAyI4zJn4JUO7go4qFyb+hTr64wFdXrxBBqgOIXblMYeAtR7toGxPl1OFfWVG
 9cdeES0miPKZ/ecDStlLYbAxbxncfCQzHhzybWVQDtZkBBQIu+Odx20Nn9me2fcT/oHvjqcoyQK
 Wbmi5XMzZ8gCty1MujvMR9sIohnSWSS02AleWe0eUxIdJIVyYkv9DnclaUqE/jUrIh+PCfiwjOW
 ybYFMy4ziVAudOl6i2w==
X-Authority-Analysis: v=2.4 cv=N828hG9B c=1 sm=1 tr=0 ts=6ab392ab cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=MpUze-A7R06OsIlp248A:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: ZfIDfOS_Yv57Pf1THTLbfyBWgr40O-AO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230035
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

On 9/23/26 12:38 AM, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> A failed qcom_scm_assign_mem() aborts fastrpc_rpmsg_probe(). On SDM845 this
> turns every SLPI subsystem restart into an endless probe failure loop:
> 
>  remoteproc3: crash detected in slpi: type fatal error
>  remoteproc3: remote processor slpi is now up
>  qcom_scm firmware:scm: Assign memory protection call failed -22
>  qcom,fastrpc 5c00000.remoteproc:glink-edge.fastrpcglink-apps-dsp.-1.-1: probe with driver qcom,fastrpc failed with error -22
>  qcom,fastrpc 5c00000.remoteproc:glink-edge.fastrpcglink-apps-dsp.-1.-1: rpmsg_dev_probe: failed: -22
> 
> The first assign succeeds and hands the reserved region to the VMIDs
> described in qcom,vmids. qcom_scm_assign_mem() reports the resulting
> owner set back through @srcvm, but the driver discards it, and nothing
> reverses the assignment in fastrpc_rpmsg_remove().

Making it do so there sounds like a better fix!

Konrad
