Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E87CCF2E3
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:00:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 022FE10EC78;
	Mon, 19 Oct 2026 12:00:13 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FBA910EC5D
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 12:00:01 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OrNf1665443
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 12:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6w/w7NyM2M/WyE9YFhQuhHJ6Ubd2mIWba5kyEyLKMtE=; b=Lajoh6zg6aeyfvP4
 Sa5jc/Rmq4UMjtfNhnnjO80rfSIba2GV5TaiOWau76x3INtb7/usAcQRd5Zv+r3c
 vG/LFFOKIGetdbNWidFyyiZpa8ichrbiSxW/JPSfleiKhdI83HYr/6wBqu3Okj05
 YHgkcypdjQCOcxRBctbhROuOs8fsWmlNVR7r4Y0ayt4ExE3XhMX3lD6c0egctb5d
 9xeoUOzlLUSrcWZlCtxKXNudhBTOQQXVQYWKEvFIEsppL2LxtdegQwYF64omDzYa
 eEHkEjOLxlhZPc3qYNGrCiCa0ZBEUDnpF2NZmahPzUuAUIYsrhsPderw7RC0AQkJ
 8gCSvw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3n0y4p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 12:00:00 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5362ce9df1eso2777001cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 05:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792411200; x=1793016000;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6w/w7NyM2M/WyE9YFhQuhHJ6Ubd2mIWba5kyEyLKMtE=;
 b=KrrBlnIywh9F1AEG9+uk2FifM4ZF9XBfm3VjxftNnvuva0g92KL+RqOyy+hP4Lk71J
 acVZdXAgKnbYWp43VpsJN4KwFjndwhSi4EfgIBe28s99JXJPlKbOr3I8/eIBH+Gjel8B
 ZH1a9ZBWjsHNXpCNDQTt4LfV+6Cyn7WtfUEv0ijCcULWN8MBQ8kqy9JyW4soh52TP0ui
 8SW/JhggBMRAHP92COYTPWa5426/iZ/9xwseL49YMWuwbxjU1OLiEau/+2liKjBNhdEo
 C66+lvG5eBq5g9Q9rQ38zqgJZXSe12q0Fuxr+GgRw2uzZ705yA6SJe3VjdroJ/w8xrDZ
 nMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792411200; x=1793016000;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6w/w7NyM2M/WyE9YFhQuhHJ6Ubd2mIWba5kyEyLKMtE=;
 b=gkgOZ0JIDNPcqluJZ83HAV7QMGuuXTLl/6Me59cAr7N4eSbuF4VEAfeJWgRJS7zHMV
 WZ0MDxnOA+fyIGp8Jb8d3TZrUMgxaYYuMCdoE+qHGOMGs0Jb1oo3RwVD+8Jrycdg6y52
 J/ztRQQJyOjF4f5KkQAFtbPfN5Wy1R+RxuLraX6AKpsGqh5/+J3qPOwE+QN/B0MbFbG0
 Ib7Zp/gn4OMRNwf6d6GWDRzN/ILxn7NQGitcHa4emAfk+7C+15tgS97HC4lHv1jH3rrr
 vIgN57JY1Uk0LjWUr/pLtmojuTGGLJ242snj7dwOcwAY7v1cXZmNKtuST/48D1LerQ5/
 LWcg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwx98RawrHTFTHONrmPDDkTrgSHmB5J3+CMNFyM3WHGXzeie/BF8EEXpy0GOJw9TVZPALK1NHosAI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL7gr1bANWosfgj19iBt2w56kdvKjIxy5hVYm2yKlUR3yyey15p
 Tjuw7pwTAToS+UTENxpA8vR4hfFxksUuL8oQRneTFHvQ5/hoESJm/AdD3oCjZR+xy05pJvYhK6y
 LdduMlBRiK+60/9Gfi2M5zMGmeYspYmmvhkn+NYExkd9EazrThPaCHEiE3ufv0YbQ1tK6YW4=
X-Gm-Gg: AYBFou0efIr0hVr+JpWO0Ltylr9yP+KBSjwwPY/+9wyq5x1lxfGuca19uwDIy+GvBt1
 8nSAcB3fhqA2mvKDCCxdCRAay1LjJKXViUldzUY4Uaj5/1ui3MMzmL3IVmcyMqQPqdYSGOE4o7i
 YG9yw67Q20AgJemPpSip/lf9sz0Ugbh+MvAY2XXzr4aa5tNpqqETKrFA8QvHP7I+GhoWgPRNxqY
 KLWyvj2eZaC4TelWlziJLzQVsws4tvfHk4zT9XKa1eLVxglZsUi5heAh5CTksJ/1szyB+PiPUFa
 qcfgP6v9ZIkgb3HtqpxZQXY7L44jWP7J4EIUkCWqxTMNn60Gs/5R8qX/IOTMzik4tY3RHjIACGk
 Us5uMsUnzQaAGpSxe5mjS2w==
X-Received: by 2002:a05:622a:411:b0:535:162c:2e81 with SMTP id
 d75a77b69052e-5364616cceemr134121001cf.5.1792411199582; 
 Mon, 19 Oct 2026 04:59:59 -0700 (PDT)
X-Received: by 2002:a05:622a:411:b0:535:162c:2e81 with SMTP id
 d75a77b69052e-5364616cceemr134120601cf.5.1792411199024; 
 Mon, 19 Oct 2026 04:59:59 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c40912ce122sm364995966b.32.2026.10.19.04.59.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 04:59:57 -0700 (PDT)
Message-ID: <0829d45e-a55a-43f6-a9f3-f445337fa00f@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 13:59:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] regulator: add Qualcomm LCDB driver
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev
References: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
 <20261019-sm8150-display-card-v2-4-86c05068efc5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261019-sm8150-display-card-v2-4-86c05068efc5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NyBTYWx0ZWRfXzpLoBYpmBjlN
 2gQ2xAqyJWGacQB0PMM2/cB1ILjrhZUWu5cBgSMWTg/zy4ngBSJXJ/ST6LTpZxS8xxJ2cH6PJAB
 6xbBHRrb6wm+hH0H3Uhx9WboxgNCVPs=
X-Proofpoint-ORIG-GUID: X4XEFyOHGwdaEtI1lBBZ2GOB-avG1I0f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NyBTYWx0ZWRfX8ZnKI5gBTau2
 YdZiMsG9V7YdgPvFWJzBPKzO8E5/yEJgrUfkEhVfqMnLXLe+OFNn4BknzNifCXaij/u5ofXCDpK
 0O24A6lEVTCmZKxxdNTnK1SNWXVyUF+Lr4YcclZqY4raXVAfCiy00kJIszzga8Naqm0jHsgax28
 CjorO2INQG6zA5syss6tzkyeMKFpH6How5Ml4qeVCfStNPCsKidzjPBGKTzFs9NAzEyelyh/moQ
 QjvMcmpM8HOG1AGOCsVU8q1fFn7Qjy859QS4Jx3PWGyEq0q04vvIoaEEWdbZ5bVRCR6hNE2blly
 PhW05LzhyuHDXCqux7yBLSHuXJEPeOGN0/inTXjRfeR8WCeMr/FeRdE5JOLc96vcJzNO3zHikZ6
 UAbpW42o6XXOnbqmlTuCUPmeH4cJdP7f+NK4Jtslbs1e5Pr/1NQvnr8BXiZiH29cMWPEG9ajehu
 sf9op1MFLbApiS6vZjQ==
X-Proofpoint-GUID: X4XEFyOHGwdaEtI1lBBZ2GOB-avG1I0f
X-Authority-Analysis: v=2.4 cv=Zf2IpcVA c=1 sm=1 tr=0 ts=6ad60640 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=6RkV1gTEqpm7dquCeG8A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190047
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

On 10/19/26 1:25 PM, Dmitry Baryshkov wrote:
> LCD panels on boards with PMI632, PM6150L or PM8150L take their bias
> rails from the LCDB block. Without a driver they only work as long as
> the bootloader has enabled it and nothing turns it off.

[...]

> +static bool qcom_lcdb_handle_sc(struct qcom_lcdb *lcdb)
> +{
> +	guard(mutex)(&lcdb->lock);
> +
> +	if (!lcdb->enabled_mask || lcdb->sc_disabled)
> +		return false;
> +
> +	qcom_lcdb_module_disable(lcdb);
> +
> +	if (ktime_us_delta(ktime_get(), lcdb->sc_time) > LCDB_SC_RESET_CNT_DLY_US) {
> +		lcdb->sc_count = 0;
> +	} else if (lcdb->sc_count > LCDB_SC_CNT_MAX) {
> +		dev_err(lcdb->dev, "persistent short circuit, keeping the outputs off\n");
> +		lcdb->sc_disabled = true;
> +		return true;
> +	}
> +
> +	lcdb->sc_count++;
> +	lcdb->sc_time = ktime_get();


GPT:

The commit message says to restart up to ten times within one second,
but sc_time is updated on every fault.

Konrad

> +
> +	if (qcom_lcdb_module_enable(lcdb)) {
> +		dev_err(lcdb->dev, "failed to recover from a short circuit\n");
> +		lcdb->sc_disabled = true;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static irqreturn_t qcom_lcdb_sc_irq(int irq, void *data)
> +{
> +	struct qcom_lcdb *lcdb = data;
> +	unsigned int val;
> +	int ret, i;
> +
> +	ret = regmap_read(lcdb->regmap, lcdb->base + LCDB_INT_RT_STS, &val);
> +	if (ret || !(val & LCDB_SC_ERROR_RT_STS))
> +		return IRQ_HANDLED;
> +
> +	/* Blanking time, a real short circuit is still reported afterwards */
> +	usleep_range(2000, 2100);
> +
> +	ret = regmap_read(lcdb->regmap, lcdb->base + LCDB_INT_RT_STS, &val);
> +	if (ret || !(val & LCDB_SC_ERROR_RT_STS))
> +		return IRQ_HANDLED;
> +
> +	if (qcom_lcdb_handle_sc(lcdb)) {
> +		for (i = 0; i < LCDB_NUM_RAILS; i++)
> +			regulator_notifier_call_chain(lcdb->rdev[i],
> +						      REGULATOR_EVENT_FAIL, NULL);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int qcom_lcdb_hw_init(struct qcom_lcdb *lcdb)
> +{
> +	unsigned int val;
> +	int ret, i;
> +
> +	for (i = 0; i < LCDB_NUM_RAILS; i++) {
> +		ret = regmap_read(lcdb->regmap, lcdb->base + qcom_lcdb_vreg[i], &val);
> +		if (ret)
> +			return ret;
> +
> +		lcdb->uV[i] = qcom_lcdb_sel_to_uV(val & LCDB_OUTPUT_VOLTAGE_MASK);
> +	}
> +
> +	ret = regmap_read(lcdb->regmap, lcdb->base + LCDB_ENABLE_CTL1, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val & LCDB_MODULE_EN) {
> +		lcdb->enabled_mask = GENMASK(LCDB_NUM_RAILS - 1, 0);
> +		return 0;
> +	}
> +
> +	return regmap_set_bits(lcdb->regmap, lcdb->base + LCDB_MODULE_RDY,
> +			       LCDB_MODULE_RDY_BIT);
> +}
> +
> +static int qcom_lcdb_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct regulator_config cfg = {};
> +	struct qcom_lcdb *lcdb;
> +	int irq, ret, i;
> +
> +	lcdb = devm_kzalloc(dev, sizeof(*lcdb), GFP_KERNEL);
> +	if (!lcdb)
> +		return -ENOMEM;
> +
> +	lcdb->dev = dev;
> +
> +	lcdb->regmap = dev_get_regmap(dev->parent, NULL);
> +	if (!lcdb->regmap)
> +		return dev_err_probe(dev, -ENODEV, "failed to get the parent regmap\n");
> +
> +	ret = device_property_read_u32(dev, "reg", &lcdb->base);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get the base address\n");
> +
> +	ret = devm_mutex_init(dev, &lcdb->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = qcom_lcdb_hw_init(lcdb);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to read the initial state\n");
> +
> +	cfg.dev = dev;
> +	cfg.regmap = lcdb->regmap;
> +	cfg.driver_data = lcdb;
> +
> +	for (i = 0; i < LCDB_NUM_RAILS; i++) {
> +		lcdb->rdev[i] = devm_regulator_register(dev, &qcom_lcdb_descs[i], &cfg);
> +		if (IS_ERR(lcdb->rdev[i]))
> +			return dev_err_probe(dev, PTR_ERR(lcdb->rdev[i]),
> +					     "failed to register %s\n",
> +					     qcom_lcdb_descs[i].name);
> +	}
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	return devm_request_threaded_irq(dev, irq, NULL, qcom_lcdb_sc_irq,
> +					 IRQF_ONESHOT, "lcdb-sc", lcdb);
> +}
> +
> +static const struct of_device_id qcom_lcdb_match[] = {
> +	{ .compatible = "qcom,pm8150l-lcdb" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, qcom_lcdb_match);
> +
> +static struct platform_driver qcom_lcdb_driver = {
> +	.driver = {
> +		.name = "qcom-lcdb-regulator",
> +		.of_match_table = qcom_lcdb_match,
> +	},
> +	.probe = qcom_lcdb_probe,
> +};
> +module_platform_driver(qcom_lcdb_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm LCDB (LCD bias) regulator driver");
> +MODULE_LICENSE("GPL");
> 
