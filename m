Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4258C61DD9
	for <dri-devel@archiver.kernel.org>; Sun, 30 Aug 2026 15:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5A4310E1E1;
	Sun, 30 Aug 2026 15:00:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="VeZncoVL";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="OPDVAwhE";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BA8610E1DC;
 Sun, 30 Aug 2026 15:00:05 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67UEt29C3702233; Sun, 30 Aug 2026 15:59:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=PEWMEmeB483IZ+wD97r7d5miICHzqxBC2EOmuleeLpE=; b=VeZ
 ncoVLuSVn2loqtD+zldiDNwvKT4wK5i6fja9x7UN+fLCcdv8ZqQ+yrPzkvEwmzSQ
 bUsnJiWnPASOUT/CiF1N4ZHunE+Xr4KWsH+yVcBVa93iuKVAo7+bmb9J025apcpS
 sAzMPf7byndmFGP2AJYeanU2gD3jxdl+gI7N+cu0P4QbK4fCn+DUnDeuinP9A9wX
 dj7+dQm0cSbKknmnohPZiFKx6EMBzSDzr4Rld2i7H6pV1pxCDxK9GYC7qnT9ssT4
 Kgv/FPO9ArzivQcs8IhX3jq0WU7tdpZScMuy/m9VM4Bv1G7H1YsnWmVfS81TNnie
 cQP3tH4RJe2cZJwSfsA==
Received: from cwxp265cu009.outbound.protection.outlook.com
 (mail-ukwestazon11021085.outbound.protection.outlook.com [52.101.100.85])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gbqgv8x2b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 30 Aug 2026 15:59:49 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxDn4K/UKJeTMxyR3zlsqsBSrlXekFtnrmmzPeosWcQRqm/jGS+K1LTfAgckyGLt+lIyobnTXimgccYVf2TECBw9Tw/B1UhWz/ZI/rFq0yty7QPWGzEMyfbwwTd+Q2e3IDSqsTD7tRwipGLGI8oEF3X+pU69rBM36s0Pq0Azg/R+dJzF5gTh5ZTRx6gGUxZwU4o76CDKRzFQCdYSpJd+h3KQ2cjhZdYCIG8xbay8UYbR9gACuQtOADlEQxlaLCSofmoGdC71DSMctqYh5ab5DyOwSGbZ3JGieEGhcTsrU4miMRPQr8tvJADBD3hNEgwmeHpoGZZFOs/NgRKbIfWESg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEWMEmeB483IZ+wD97r7d5miICHzqxBC2EOmuleeLpE=;
 b=B7ok/zC75bLXD/rxXYDwnizKdwG+VSY9LFo/CGV25j7yn2o4VQgzacSwE1WVtQe5fJJ/JiTQbWifkqlZcxIw1o6iF10XbaOt1xGRWqPFDe1R11BBQtPEc3M9vq/dEzJSbKPKkjmOTzBjVFDRQrhwzCphEMRMNvmoP+RtpRmSas5k99XV00Lw6+lUz8xCDgGyf9035YFPptQCEiQ1UE6HwFLzfXFxdMYwZp4ii/jrakMti7tArPtqwEsXxcRW0VWVBbleSJ5GeYOQP/9nIs3t5tdW5ixHlYMFZTvsli0K41nlMeifmKvxIBBQsT5W7rS55yLosXqGGAaa86rwvmscpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEWMEmeB483IZ+wD97r7d5miICHzqxBC2EOmuleeLpE=;
 b=OPDVAwhEz7kpGS+NDwe43lry5+GxauQzO3LsAqNZjop+EquWkYMdUUaLNz/+5WkHVs6ZHLl5nzMmQPd+JWIV5cxVehC98r00uEWdQLZDDj7yyyM1s7WuIK+i+/NbHo45FdoriXct0IMpWNuUvKgD4iAvw7ymcjx4Vhv668FQKrQ=
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::7)
 by LO7P265MB005679.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:607::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 14:59:46 +0000
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237]) by LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237%7]) with mapi id 15.21.0360.008; Sun, 30 Aug 2026
 14:59:46 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: Alexandru Dadu <Alexandru.Dadu@imgtec.com>
CC: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "imagination@lists.freedesktop.org"
 <imagination@lists.freedesktop.org>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>
Subject: Re: [PATCH] drm/imagination: Fix NULL pointer dereference
Thread-Topic: [PATCH] drm/imagination: Fix NULL pointer dereference
Thread-Index: AQHdKlBL2C5INDka/EKCnbQwDzGfl7a2y8EA
Date: Sun, 30 Aug 2026 14:59:45 +0000
Message-ID: <fef46ed35ee83c4949306ebe18ed13aa90686095.camel@imgtec.com>
References: <20260812-fix-null-pointer-dereference-v1-1-f69b2ffe9520@imgtec.com>
In-Reply-To: <20260812-fix-null-pointer-dereference-v1-1-f69b2ffe9520@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB7076:EE_|LO7P265MB005679:EE_
x-ms-office365-filtering-correlation-id: 09e2e56c-8434-4b4c-f47e-08df06a754b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|56012099006|38070700021|10067099003|5023799004;
x-microsoft-antispam-message-info: U8OooH4smRcDxhirTZSkoTQIZDb0rILnKh/Fr5OGz253xXLk7MtladMDGLjvfTNHOg+vww67w829xjrLogWy/xmk0GKa3UjhpzjrvATCyXj3EN8r06tcRyjoByVH9lTbuJE0ajMyZImWt9XvkF/N6FqpISkJNBpIRta4FC8DW/NXJW4ZfcLRuS/xqrqrCRYFx6szcdjAMUD2+7i97dDaIqW36H7yoY2kF3QfKC+LlMKt3pTJGl3qKOrcu1v/nd0CiQmb35kbBaLoJnB0zOfC5ynzJNX59wVDlGTifONBXaPkcomIBLbvfwrikxYBeYlz7WeJRYNArhF09s9XP6IMequXCT70SJgiepwFYz9935d8Xtpdeuu+AtDXlOL/S5wY7tLQ72e8I2hql7ms09jk+j/EglKaPsNpQiitSYfq4s1FP+TVRy+5yzzcGR1MOwin9q4O01IYI2pe0krCRrqjKRsh7WRqzjhjyvFj4ShP+7Hw/pH6iofuobhpQO628mnQzkm6bGLaW/Xy708G0eRSV2MiyX7jb30cpI72S9iyqsXZ2RGYRDYdZQDOmCtm77CBWIlQMHQfxVapDGldwbFJH7RxdYOJMow1CiHwaw3M1XXAaN/aZebqkhr/oPEvbsulWLErl9LR2bcQE5KXw4QRZmypsjY6WMVLexgXbzGibDvXfuydhJyHG9h/EqnatdCt3cd1zkn3inA8bIEKMibQZYq28CtM3Z3iXWWMjM7Caq8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099006)(38070700021)(10067099003)(5023799004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGo2Smhoa0NiWFBkellrMVhrNk9QYnMvaWZUSVNNRCtUciswODB1MHZuVytS?=
 =?utf-8?B?RGFCeUhWdXFGaWV1UTB4UkhrVUlXeGc1OXpSL25NamVmblhjVVk1VFAwb1Y1?=
 =?utf-8?B?SVpBYzRKelJ4K3NCMWR1V3kzQUFRQTZtc2ZJK0NITDNwdFVLL3AwVFBtbUtM?=
 =?utf-8?B?TzY1MHhtc0w4ZUtLYTlKS3BHazFHSWJwRzFyYitEVmtBZ2lqNXJSTndrZlM1?=
 =?utf-8?B?YStNSjkvc2xGSTdxS2FLMnFUMTNqRlpIdFpTNDBEWnNTY0ZhV2cyUWpNcWlJ?=
 =?utf-8?B?V1pUdDY5VldYWWJaUk8rKzFwK08zTW5tR0xvSHJGZThNLzJ1YjhLeTFVS2xl?=
 =?utf-8?B?NlhwUytVSUFSbmUzbXJRa0VsR29wekFBUWRqbEJZMU51Z28yK3JFL2hzQmY5?=
 =?utf-8?B?RUQ0aGUzQyt5WFlXVENqQkJyZ2s4Y0p6NGROU2xpa2pUNUo3MTRKUnpoUFlD?=
 =?utf-8?B?ZENsclRaRjFYTmFnMW1pR2p6ZmlNcHR3TEU3YUJiMUFTWmpnZmV4RS9kTzNH?=
 =?utf-8?B?OWw4ZEtMR0ZvR1dDN1ErT2FBTHFSREIzeGNzODFHREdzdTB5Vkh4RFZzSkxV?=
 =?utf-8?B?TUduOWV2UUpSbUlZUW9tM3lpYWUyOFFJcDFvK1A5Q0xTTFRnZFcwQnVneHc4?=
 =?utf-8?B?eXp4NStIcHhCd1c0eStnTXdieTVMZkkxa1U4aUVKdHV3dXNobFBGUGNRR2VH?=
 =?utf-8?B?WlNMZUFydi9ZenZzVDVMcjYyakNaQ1dRS3k0OEFVanFrWHdybjh2UUZwZW94?=
 =?utf-8?B?Z2UzTFpTNTF4VmhHS1dyYkp6OHpSUVF4aEVqY245UDlNRlNCUG95NTl5N2tT?=
 =?utf-8?B?c200eE9LRFR6a0l2T1ZqV1hHc2ZBN0ZoQlAyOHNRcVhlUjRqYUZOa2czOFJp?=
 =?utf-8?B?aDdYN1JRRWZVa05LUkxQMEN1L0d6Y2YwckRxSVQrbkN0Uk1TdWRuVkNJWnFX?=
 =?utf-8?B?eTNuNjVQN3pYUUp3UEcvS0k2ajNPQnluQ1pVN2g4bW9VQUFKOEdIWGZpKzNQ?=
 =?utf-8?B?YTJNOGZUNk96RzJpMjhKWjZtcmRrQnloVDAxckRNQzZ0NVB1ZW1TYmd0UmZG?=
 =?utf-8?B?Z3paQlltT1UrU2VLcitBQnRzN2tJSnJWbmxtTUhHa0VrUnRTemZSbHZ0d3l3?=
 =?utf-8?B?bzd2Q0NkM3ZJSHFRTlViTFJ1U0l2b2xLVEg2UDJqd0hzaGxuVEJLL01oWTRq?=
 =?utf-8?B?OE8wM2JIRzJhQWZ6eVQ4SDU0SkRIVDd1d0FTZjBsRkx6czRuUXU0eDJUdzJp?=
 =?utf-8?B?dWY0UGVWS0tQOXpqL2psY0ZTSEV1UzJndTBlc0MxVDdVMGpOSmt1WldzcUxh?=
 =?utf-8?B?cVFVSE1rRmxMblB3QVlqRGM2TWZpVy9XbXlHTWdZQ1BYME1pMk9qMEVKNkti?=
 =?utf-8?B?TU4yQUhEZlFsNG5WRjlzaUZJRlJ1ZEltRjZlb1RrQk9ybmxjbGdsdDJ1eTM4?=
 =?utf-8?B?RFJpVElsT0Q1SjdudjhUK2N3SW5xOVZiSHlGbjRwUzFNTnloendVcXNOcVdZ?=
 =?utf-8?B?aFlyei9qbGZwMGp4M29jc1ovV21OckszOUh3cWhwUVh3dmYwUkkvSlFBeWZS?=
 =?utf-8?B?YlZwcmpQejJCc3M2V3JNWk4rZEFCQWRSenFNazRJNFh2ZVdNU0hrdjE2SWdu?=
 =?utf-8?B?eEF0RHlQbUpTKys4cmpKVC9leWJ4VkEvT2tJcWhMcnNnWWJPN0t6VnJxN0xZ?=
 =?utf-8?B?MWREQTRhZ1JjRml2UGYrMlYxVFB2UnF5ODBqUTc0U0VLNXlvMnJLRlprR2Rz?=
 =?utf-8?B?bTZ3Y09jNzJkemVLVkFnbjN0aWM0Z1ZwUWhkbXdLL1BBS3NqZ2ovWTlrYmND?=
 =?utf-8?B?TUU3czFSSUszQ2J4YWhoa1Rja0RMU0RKTzFyWnoxSWpVNFgyVU1EdUc3SG9O?=
 =?utf-8?B?RVlQdUdsUDk4dmVKVXVaSzB3ckh6aDlDQkgzaG5XYjFxaUV4ellaZUJyMUlv?=
 =?utf-8?B?UEFBTGR1R09UZzlQYWk2ZkJRa0RjdjVsdG5PbFhQY0prK0hseEVqZnlIVVpS?=
 =?utf-8?B?TXE3N1hlU2dLZDlZY2R2M2lJU3BvTUpBUEtJOTgzOUl0WVpGUHB0MTZJWnpS?=
 =?utf-8?B?TjlDSTJ1WVM0RHFwZjZ5TkJRNEYxa1Q2ZlM2ellIOUJHK2FxR3VucFJ6TXh6?=
 =?utf-8?B?a3FnbW9LUS9sTG1sODQwSTdFTjk3MjlmaEFJczhjaURLamc0a2gzb0ZLSHNP?=
 =?utf-8?B?NzJYdWcxQVYvWjJjeUtZbmN3Zmh4WDVhL1ppaGlHV1FSZjlwdklJOXk4NVBH?=
 =?utf-8?B?L291akhveTlRd1g4OHlDU3hLUllGZTZmdFNPKzQ2eWxOZE4yMHJRa3h6R1kz?=
 =?utf-8?B?bStzZlJDVUdjVXV3b1QyOWIwbVg5Y0NpWUFZOWlzZkFjMUo1MzJVVHJGWk1h?=
 =?utf-8?Q?45TSBDqg1Umy+RJM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <528C7AF9A8CA6D458F452F28D6530449@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: my3n40zHjx+egAKh47sSBg70HSnyAYWdoT6XXsUlf1fATu/i6jZV02fmsLDOVxcVVat0j9n05ftofUJ6br20PrzXQz2J/gXyMLi3WiGEvMjB3UsAptvscXTToBJv+38E9pYDz/om+5fdYci9ruxjSKKkulje2QUYWcaiZ6JZAfAPsOI1/gNrA0JRV+/pKAhjr13jFnQOND99Mq34oziUeqy8KWyx7O+RoMxqUXmQmGBD7tBlbZwgc4bTeNbz87HNLskkCBsrbelR9HO9cT6B3Uf2yG1P49AUzVgeVxG2Ug1F+g9RqeXYpjqEvEICe6+OWXyzA/rcU3PlGErPJJfsag==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e2e56c-8434-4b4c-f47e-08df06a754b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2026 14:59:46.0385 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s/fT/59d/M3aGPZ1/qSL5xrkJ5mPMWknTpG4/kppqVmW71UBj1SecAe4YSiH1X3cd4TbAlci6HU/StK/YRnU7RSWe066RjlWT6sJm91VAbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB005679
X-Proofpoint-GUID: PYDNCxNv91Doylg2AlSlyINdf_mcI1B0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMwMDEyOCBTYWx0ZWRfXx+WaGW8rePBj
 KPoJ6A+Uqge13z9/I0S6wl+IHHNSS5r/kj4K9iAFBoxHKVbjWmWqcyWufF7IuHpFPIi9paYn09y
 ZKM6HAJjH6K/4NIhzlFO/4agmJBvSAdu4BKpOZLFpiaSKRs2O86DogG9ckzqBCZY+JabECG0gUd
 mv+qTqSA21e4rhjVl6gIv5zsq/y3LBk86COhAfNF0ZNOw3SZ03ZMemXcUU3Cz8flXsQSdlJDQNM
 1MePkYoyXaJ6dzeRlNaVXW1oDyXH9NEepozjcacJ0gJYUDe0CvFN62e8dOeNAD3c+h+GXpqhFGx
 Wr5z5dIPT2zc2kFnP5QfFMaC1FByHJ7SskjLlYnNp9VkPMD0tEMfezYuqboKqVQQjLCTKyLe/5G
 zlzr4gEn/i6IOJZB0yd57A2n+993Rsfd6ehvotIlvP8i1nTD6kaPjbcc75+3YPxv4zxY63NKyD0
 q/rjQ960v6xGhRDZ8VA==
X-Proofpoint-ORIG-GUID: PYDNCxNv91Doylg2AlSlyINdf_mcI1B0
X-Authority-Analysis: v=2.4 cv=OcCQnBTY c=1 sm=1 tr=0 ts=6a944565 cx=c_pps
 a=gcGV6/u4+zGVzz+KJd0EHw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=VwQbUJbxAAAA:8
 a=r_1tXGB3AAAA:8 a=YKWntSRVss0vrGeQPbYA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMwMDEyOCBTYWx0ZWRfX73rFJAa4WGUZ
 UquKe8faOIgJ8BirtUYNaO1/wudrnTaF+MGrv3G+j6uVlLBhTAnmt0Ll+/hbRpJCUDl11Jjvubj
 ab4ozTWds6wSxyEvGxIQtCRw4Bfg3AM=
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

SGkgQWxleGFuZHJ1LA0KDQpJIHRoaW5rIHRoZSB0aXRsZSBpcyBhIGJpdCBnZW5lcmljIC0gY291
bGQgeW91IHRyeSBhZGRpbmcgdGhhdCB0aGlzIGlzIG1vcmUgbGlrZQ0KZml4aW5nIHBhcmFtZXRl
ciB2YWxpZGF0aW9uIC8gdGhlIGJ1ZyBpcyBwb3RlbnRpYWwgKEkgdGhpbms/KSBhbmQvb3Igd2hl
cmUgaXQNCmNhbiBoYXBwZW4/DQoNCk9uIFdlZCwgMjAyNi0wOC0xMiBhdCAxNDo0NiArMDMwMCwg
QWxleGFuZHJ1IERhZHUgd3JvdGU6DQo+IEZpeCB0aGUgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNl
IGZyb20gcHZyX2Z3X29iamVjdF9kZXN0cm95KCkgd2hlbg0KPiBoYW5kbGluZyBhbGxvY2F0aW9u
IGZhaWx1cmVzLg0KPiANCg0KTWlnaHQgYmUgd29ydGggcG9pbnRpbmcgb3V0IGhlcmUgd2hhdCBT
YXNoaWtvIHNhaWQgKFsxXSkgYWJvdXQNCnB2cl9md19vYmplY3RfY3JlYXRlX2FuZF9tYXBfY29t
bW9uKCkgc2V0dGluZyB0aGUgR0VNIG9iamVjdCBwb2ludGVyIHRvIE5VTEwNCmJlZm9yZSBqdW1w
aW5nIHRvIHRoaXMgZnVuY3Rpb24uDQoNClNwZWFraW5nIG9mLCBhc3N1bWluZyB0aGlzIGlzIGEg
cmVzcG9uc2UgdG8gWzFdLCB5b3UgY291bGQgcG90ZW50aWFsbHkgYWRkOg0KDQpSZXBvcnRlZC1i
eTogU2FzaGlrbyA8c2FzaGlrby1ib3RAa2VybmVsLm9yZz4NCg0KSW4gY2FueSBjYXNlLCB0aGlz
IGZpeGVzIHNvbWUgbG9naWMgc286DQoNCkZpeGVzOiBjYzFhZWVkYjk4YWQgKCJkcm0vaW1hZ2lu
YXRpb246IEltcGxlbWVudCBmaXJtd2FyZSBpbmZyYXN0cnVjdHVyZSBhbmQNCk1FVEEgRlcgc3Vw
cG9ydCIpICAvLyBwLnMuIG1pbnVzIHRoZSB3cmFwcGluZw0KDQpbMV0NCmh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2RyaS1kZXZlbC8yMDI2MDgxMDEzMjIwMi4zQzE2RDFGMDAwRTlAc210cC5rZXJu
ZWwub3JnLw0KDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRydSBEYWR1IDxhbGV4YW5kcnUuZGFk
dUBpbWd0ZWMuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJf
ZncuYyB8IDI4ICsrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxNiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3LmMgYi9kcml2ZXJzL2dwdS9kcm0vaW1h
Z2luYXRpb24vcHZyX2Z3LmMNCj4gaW5kZXggODUwYTNlYzhlNzc1Li44OGYxMWZiMDEzMDQgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZncuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3LmMNCj4gQEAgLTE0MjUsMjIgKzE0
MjUsMjYgQEAgcHZyX2Z3X29iamVjdF9jcmVhdGVfYW5kX21hcF9vZmZzZXQoc3RydWN0IHB2cl9k
ZXZpY2UgKnB2cl9kZXYsDQo+ICAgKi8NCj4gIHZvaWQgcHZyX2Z3X29iamVjdF9kZXN0cm95KHN0
cnVjdCBwdnJfZndfb2JqZWN0ICpmd19vYmopDQo+ICB7DQo+IC0Jc3RydWN0IHB2cl9nZW1fb2Jq
ZWN0ICpwdnJfb2JqID0gZndfb2JqLT5nZW07DQo+IC0Jc3RydWN0IGRybV9nZW1fb2JqZWN0ICpn
ZW1fb2JqID0gZ2VtX2Zyb21fcHZyX2dlbShwdnJfb2JqKTsNCj4gLQlzdHJ1Y3QgcHZyX2Rldmlj
ZSAqcHZyX2RldiA9IHRvX3B2cl9kZXZpY2UoZ2VtX29iai0+ZGV2KTsNCj4gKwlpZiAoIWZ3X29i
aikNCj4gKwkJcmV0dXJuOw0KPiAgDQo+IC0JbXV0ZXhfbG9jaygmcHZyX2Rldi0+ZndfZGV2LmZ3
X29ianMubG9jayk7DQo+IC0JbGlzdF9kZWwoJmZ3X29iai0+bm9kZSk7DQo+IC0JbXV0ZXhfdW5s
b2NrKCZwdnJfZGV2LT5md19kZXYuZndfb2Jqcy5sb2NrKTsNCj4gKwlpZiAoZndfb2JqLT5nZW0p
IHsNCg0Kbml0OiBjb3VsZCB5b3UgcmV0dXJuIGVhcmx5IG9uIGludmFsaWQgcG9pbnRlcnMgaW5z
dGVhZCBhbmQgc2hpZnQgZXZlcnl0aGluZw0KYmFjayBsZWZ0L3VwPyBUaGUgY2hlY2sgYXQgdGhl
IGVuZCBzaG91bGRuJ3QgYmUgcmVxdWlyZWQgYW55bW9yZSBhZnRlciB0aGlzLg0KDQpUaGFua3Ms
DQpBbGVzc2lvDQoNCj4gKwkJc3RydWN0IHB2cl9nZW1fb2JqZWN0ICpwdnJfb2JqID0gZndfb2Jq
LT5nZW07DQo+ICsJCXN0cnVjdCBkcm1fZ2VtX29iamVjdCAqZ2VtX29iaiA9IGdlbV9mcm9tX3B2
cl9nZW0ocHZyX29iaik7DQo+ICsJCXN0cnVjdCBwdnJfZGV2aWNlICpwdnJfZGV2ID0gdG9fcHZy
X2RldmljZShnZW1fb2JqLT5kZXYpOw0KPiAgDQo+IC0JaWYgKGRybV9tbV9ub2RlX2FsbG9jYXRl
ZCgmZndfb2JqLT5md19tbV9ub2RlKSkgew0KPiAtCQkvKiBJZiB3ZSBjYW4ndCB1bm1hcCwgbGVh
ayB0aGUgbWVtb3J5LiAqLw0KPiAtCQlpZiAoV0FSTl9PTihwdnJfZndfb2JqZWN0X2Z3X3VubWFw
KGZ3X29iaikpKQ0KPiAtCQkJcmV0dXJuOw0KPiAtCX0NCj4gKwkJbXV0ZXhfbG9jaygmcHZyX2Rl
di0+ZndfZGV2LmZ3X29ianMubG9jayk7DQo+ICsJCWxpc3RfZGVsKCZmd19vYmotPm5vZGUpOw0K
PiArCQltdXRleF91bmxvY2soJnB2cl9kZXYtPmZ3X2Rldi5md19vYmpzLmxvY2spOw0KPiArDQo+
ICsJCWlmIChkcm1fbW1fbm9kZV9hbGxvY2F0ZWQoJmZ3X29iai0+ZndfbW1fbm9kZSkpIHsNCj4g
KwkJCS8qIElmIHdlIGNhbid0IHVubWFwLCBsZWFrIHRoZSBtZW1vcnkuICovDQo+ICsJCQlpZiAo
V0FSTl9PTihwdnJfZndfb2JqZWN0X2Z3X3VubWFwKGZ3X29iaikpKQ0KPiArCQkJCXJldHVybjsN
Cj4gKwkJfQ0KPiAgDQo+IC0JaWYgKGZ3X29iai0+Z2VtKQ0KPiAgCQlwdnJfZ2VtX29iamVjdF9w
dXQoZndfb2JqLT5nZW0pOw0KPiArCX0NCj4gIA0KPiAgCWtmcmVlKGZ3X29iaik7DQo+ICB9DQo+
IA0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IGU1NWZlYWQyMmZmOWVlMDQ3YWI5ZjE5MDM4NjBjNGI0
MzA0MzUxNGUNCj4gY2hhbmdlLWlkOiAyMDI2MDgxMi1maXgtbnVsbC1wb2ludGVyLWRlcmVmZXJl
bmNlLTJjODkxMTQyZDk4OA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiAtLSAgDQo+IEFsZXhhbmRy
dSBEYWR1IDxhbGV4YW5kcnUuZGFkdUBpbWd0ZWMuY29tPg0KPiANCg0K
