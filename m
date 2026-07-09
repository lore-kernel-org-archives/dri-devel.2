Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6938C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 05:49:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 568C310E38B;
	Thu,  9 Jul 2026 05:49:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cozis1wM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QhZuVBcQ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CFEC10E38B
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 05:49:56 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668N8peX024883
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Jul 2026 05:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9NALSQ0Dw5Lbqt1NCbiSIryndvAMq6kLYEDbo/CY7xs=; b=cozis1wMS8L2FUgx
 cepcsHXh0axn8p70eC4gXcGvnSVEzEUff/y8/Ky99iBpGK8p90colMWMc2PFfBL0
 tvB6OhzqP1YGXGkh5yaY2umWomva21QRb1TxbT0eIG5ZutGQjMCDKVzGqMKqHUwo
 c0CIFphtqLF9FJj1NgD7XUGojKvPouvnGHRDybeg5YtPhWPS2rMJiU3+xaMOeKSi
 7mAmIr2+1T07vW+v7vQeL+3wgoEXHnL0g/K38b8F9nEMObXIA0MLyvByT9fryZay
 TRKvrdY6auPqCuphQxKQD0YJUYbl9hoOjnoYn7nrtwGIzuoe5A50Gc6PcoMt/XkD
 9LcEwA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9hnv5312-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 05:49:55 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-37d4f23eb37so990615a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 22:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783576195; x=1784180995;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9NALSQ0Dw5Lbqt1NCbiSIryndvAMq6kLYEDbo/CY7xs=;
 b=QhZuVBcQMt6anie6pBaiaBLf+rOOWPDYYZjtc98Y7eyvs4KwZr3Tc/xdce8XMcLUDf
 hl1YCRGJw6S2rKHL4sqAudlcrT+6vcgdRd3T61nyvHHPwXsZDIlFTzt3E78Ozs4wXeWA
 nwq5L1MgM6swOgr1vvVNK6RmkGGfhI+vkwhabQo1UHad4Xy5sInnsIqtAnkpK7bjvd0f
 4x6hBu80s+bCGprDaz4EvHsn1QmKQ0gIiyCb3A9yteDHSbGbG/Ij5nL6HRfK2NgotTkT
 NP0FptfOrkPcDsU7oH+Vtu8lJ4Lwgerg7BdvSZk34/Dq+4cgq+N44qjCqslWBRxGN1Dt
 IEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783576195; x=1784180995;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9NALSQ0Dw5Lbqt1NCbiSIryndvAMq6kLYEDbo/CY7xs=;
 b=LiKeckbEotkpwNWvec4vtGVcLPR5Q5PQNPx/XTH3dsHSltM+BKAUANzNjscLRwmkty
 OEt6tMASkhLpsZ2VugFkRB9Z+EQaVFzp0dUiyx2UjytbBPO+SSTDJxIUIHq5DLxyVgil
 P+s4tpds3IqeBblhQbzaEoKmyWSK84wFrSyUHBLAZO6A+ayTtpV2DyByGS5qYHNbU2sU
 f/gdvHlNzvifpaipNopBdO9aq9KdfbglHdzdAup+ApyHpRIIM3gKXCn565VIjv7nDXOu
 iA1TOsjAxfOGLUKoTc4oiLQda4itiHYYZLcPkGiBHm+9+IOZGxyyePmI383AUT/iyKEE
 rLKw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqL65yyQ768o7lGDrcw4LRo1u99H6E7rllvzL6how5Z9WmmJjsJ3W1qTObPdiSncT0AnXazo1uV61M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxh+SJfWPke+sg1eSiM6zIwLYdsGfKhcPZYtHNF1CkNQE/vbWL8
 vzFsdWB/pauvSwjR2iX9cAxz5rAR/jcP+SRTujJzMLp2/6PW7i3eOjI3f+uUBIcBu8awdojhuEg
 Nu4CQtA+bV2qtKThGoR+8VXkIq/4MDA+5vSj1hheDGjZZFk9XAHjNJUHjBVI5pLYlbhitez8=
X-Gm-Gg: AfdE7cnWA50rhy4e1QxxJLsf315dRuAUHphtBak1OKejX0ZYWL6fqwC7Cyc01+Pq3kY
 JnkxVoC8u3oxWFF4aDPXlbNkz/9LBGPk2IcLAxVMKG+rIg736+09LZfJ4mSdZzSWG+bvAiZuAcR
 5NaLomyAjlhrJN1GqM4dbpEzpPfg6bTU6CA1ecuDuUrrR5CIh0PgcoHY8e33OjqzQ+Ym1hoHF9i
 MJDiDL95rv/6YrlA9fB0iDaWJNPu3zlkSOSISXfwQnOCsIr6z34xI0gO6GBCJaXMFv0HwqftzZ9
 IprU4VcqHKiXKSnYUPl7yLAg7LZJAN8snMGXoCRGuqZZ86HNZ8lwFysxyzACfJdpdR+s+p9SLrB
 UZREvULsbYwIYvuWzpcMncylG7JGk/DV36j0zt/bUiUU0A+xAqg==
X-Received: by 2002:a17:90b:2c90:b0:37f:f89a:a1e6 with SMTP id
 98e67ed59e1d1-3893d2429bdmr5476206a91.0.1783576195306; 
 Wed, 08 Jul 2026 22:49:55 -0700 (PDT)
X-Received: by 2002:a17:90b:2c90:b0:37f:f89a:a1e6 with SMTP id
 98e67ed59e1d1-3893d2429bdmr5476176a91.0.1783576194794; 
 Wed, 08 Jul 2026 22:49:54 -0700 (PDT)
Received: from [192.168.31.103] ([152.58.31.181])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a55a47286sm562981a91.10.2026.07.08.22.49.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 22:49:54 -0700 (PDT)
Message-ID: <734537a8-7ece-4d2e-8e72-d090d4788b22@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 11:19:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: qcom-geni: Add dynamic transfer timeout based on
 transfer length and frequency
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
 viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
 sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 naresh.maramaina@oss.qualcomm.com
References: <20260705135739.4038826-1-aniket.randive@oss.qualcomm.com>
 <81e84294-b438-415d-82ef-a523c4381eb4@oss.qualcomm.com>
Content-Language: en-US
From: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>
In-Reply-To: <81e84294-b438-415d-82ef-a523c4381eb4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KNNqylFo c=1 sm=1 tr=0 ts=6a4f3683 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9AXozQ6IwN0d4JI31gUtBA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=QsZEBUMWvTWtZ6nCauIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1MiBTYWx0ZWRfX/1bezbNf5/m2
 /tlngRuZGoMCvKr5aI7Zq9ibFnkqzi+2RODWdwR4PuIBs/Nz3HA6DvJbG6joEvXjxAEmlzm/T+7
 cxqFjZXpyIL/68EKji+0a59yLsfjfpI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1MiBTYWx0ZWRfXzvwonZcI2TtO
 rp682SnC/nN4HeBRjNYkJyfcAspT17ix6D9ua9hWKSS7B1jHO/unxWD7hGPDpRIy1bvr1zG5UJ3
 9Hf5fORmRKXFa4soQeVI4USPwQPq7Kxr/pmxb0E+i5VTpkna0+UH5N4QLj6cc8OObV/NqTbVuEP
 B/il/iVFeT0PlWYDEiJEuh2MrovdpG1fEDJ9dZckQuORMxGBPZP8x8mmhK46KBeIv56SaF85whS
 e/RKEXXcxBAkaim6ANx9vhGVidq3PKiAbbo7y6OmSsBXeo9Oo5ucBdG7t8Ffl0fwyxvMet2Wb8F
 SzPNzRpACKl4P1wOxYQz6jxwscRqBiFPJ2pzUEWyEuJjoUnGovmG8xHeSTZPGCu3ipWF4Rgp3k1
 Fb5JT9SG2lgmoDwZvVtW9WSd54fkq/U3hRCy59ruR7ey7HdMHWxbkLdrIiLOt7h34envDSOFzjW
 dsk50G1IDnvzRujqz2A==
X-Proofpoint-ORIG-GUID: fk_nw7auIXik1BuMkfJ0kvK7VOEH3dTR
X-Proofpoint-GUID: fk_nw7auIXik1BuMkfJ0kvK7VOEH3dTR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090052
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

Thanks Mukesh for the review.

On 7/7/2026 5:37 PM, Mukesh Savaliya wrote:
> 
> 
> On 7/5/2026 7:27 PM, Aniket Randive wrote:
> [...]
> 
>>   static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
>>   {
>>       struct geni_i2c_dev *gi2c = dev_get_drvdata(se->dev);
>> @@ -471,7 +484,7 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev 
>> *gi2c, struct i2c_msg *msg,
>>       }
>>       cur = gi2c->cur;
>> -    time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
>> +    time_left = wait_for_completion_timeout(&gi2c->done, 
>> geni_i2c_xfer_timeout(gi2c, len));
> Simplify with timeout = geni_i2c_xfer_timeout(gi2c, len) and use as an 
> arg ?

Yes. we can add extra variable. I though to avoid extra variable.

>>       if (!time_left)
>>           geni_i2c_abort_xfer(gi2c);
>> @@ -513,7 +526,7 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev 
>> *gi2c, struct i2c_msg *msg,
>>           writel_relaxed(1, se->base + SE_GENI_TX_WATERMARK_REG);
>>       cur = gi2c->cur;
>> -    time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
>> +    time_left = wait_for_completion_timeout(&gi2c->done, 
>> geni_i2c_xfer_timeout(gi2c, len));
>>       if (!time_left)
>>           geni_i2c_abort_xfer(gi2c);
>> @@ -591,7 +604,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct 
>> geni_i2c_dev *gi2c, struct i2c_
>>    * geni_i2c_gpi_multi_xfer_timeout_handler() - Handles multi message 
>> transfer timeout
>>    * @dev: Pointer to the corresponding dev node
>>    * @multi_xfer: Pointer to the geni_i2c_gpi_multi_desc_xfer
>> - * @transfer_timeout_msecs: Timeout value in milliseconds
>> + * @transfer_timeout_msecs: Per-message completion timeout in jiffies
>>    * @transfer_comp: Completion object of the transfer
>>    *
>>    * This function waits for the completion of each processed transfer 
>> messages
>> @@ -601,7 +614,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct 
>> geni_i2c_dev *gi2c, struct i2c_
>>    */
>>   static int geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
>>                              struct geni_i2c_gpi_multi_desc_xfer 
>> *multi_xfer,
>> -                           u32 transfer_timeout_msecs,
>> +                           unsigned long timeout_jiffies,
>>                              struct completion *transfer_comp)
>>   {
>>       int i;
>> @@ -612,7 +625,7 @@ static int 
>> geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
>>           if (multi_xfer->msg_idx_cnt != multi_xfer->irq_cnt) {
>>               time_left = wait_for_completion_timeout(transfer_comp,
>> -                                transfer_timeout_msecs);
>> +                                timeout_jiffies);
>>               if (!time_left) {
>>                   dev_err(dev, "%s: Transfer timeout\n", __func__);
>>                   return -ETIMEDOUT;
>> @@ -736,8 +749,15 @@ static int geni_i2c_gpi(struct geni_i2c_dev 
>> *gi2c, struct i2c_msg msgs[],
>>           dma_async_issue_pending(gi2c->tx_c);
>>           if ((msg_idx == (gi2c->num_msgs - 1)) || flags & 
>> DMA_PREP_INTERRUPT) {
>> +            size_t max_len = 0;
>> +            int j;
>> +
>> +            for (j = 0; j < gi2c->num_msgs; j++)
>> +                max_len = max_t(size_t, max_len, msgs[j].len);
>> +
>>               ret = geni_i2c_gpi_multi_xfer_timeout_handler(gi2c- 
>> >se.dev, gi2c_gpi_xfer,
>> -                                      XFER_TIMEOUT, &gi2c->done);
>> +                                      geni_i2c_xfer_timeout(
>> +                                      gi2c, max_len), &gi2c->done);
> Simplify with timeout = geni_i2c_xfer_timeout(gi2c, len) and use as an 
> arg ?
>>               if (ret) {
>>                   dev_err(gi2c->se.dev,
>>                       "I2C multi write msg transfer timeout: %d\n",
>> @@ -852,7 +872,8 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev 
>> *gi2c, struct i2c_msg msgs[], i
>>           if (!gi2c->is_tx_multi_desc_xfer) {
>>               dma_async_issue_pending(gi2c->tx_c);
>> -            time_left = wait_for_completion_timeout(&gi2c->done, 
>> XFER_TIMEOUT);
>> +            time_left = wait_for_completion_timeout(&gi2c->done, 
>> geni_i2c_xfer_timeout(
>> +                                gi2c, msgs[i].len));
>>               if (!time_left) {
>>                   dev_err(gi2c->se.dev, "%s:I2C timeout\n", __func__);
>>                   gi2c->err = -ETIMEDOUT;
> 

