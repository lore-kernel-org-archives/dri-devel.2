Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ECC606A327
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 10:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dGOwjLzB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7712210FAFD;
	Wed, 25 Nov 2026 10:31:57 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A77A10FAF3;
 Wed, 25 Nov 2026 10:31:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UeErkcpRVzhPmsE2yldQA8J3WB6T7um/W9YsSjIXw654alFFVpctW3X39/hVDIbc8KE0MHx03ZBvuxjln1ZOC0Oh7VrJPKquS8JKBCHPB8OfV5+Bmn4NBuK/evkSnvsCRmSnH/WHzyXhBT59TRyoe/eJryFaNoXOQ9XgvnKAyjV+jSmGiAUEAalHVF7sPXy3R5ZkZMqVLidmI500kZWR8K94esYlYT9WrKBI2aHBkbyZ3avWXsjwF1SdP6qNJE/B4+A5f8JXwQcZ5OO1aaooVzrYP+X6MXexh2QGjr1/aPlq+IvLf6zLarGuCXNoIrZqGoFM+Rbf4ya5qvBMbqysxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvPUAXdkhIuoB9fy6yuXJcO8AC9MFx9ZQYHQJygB8oo=;
 b=Vxlm0ngUvW8OZOPA9y3+wd1bYNfr62V8FBSk5EImcA1oGnKgtYzhzkccg37feu7GPhCEePj4C3cq7QJCxm0AYREykitVz1kRtf72sX4/u1OU8zRmGyVnp2gF5kmfZQBfni1gwqKSWus3pfp2WdEoPSsAmLaC8EioTpD87NzdAabzZ3IPfK6d2b8aFn9BrgwpWst6tnI+pDbsnFmxYl32ZuGvpuogrLoVL5Jg4rLyRz7Td57TOI0CcUVIJZ3ELM0rdCQr7W6nVzSB19pA+cTGBltIaRsZwmlSD+bCV950afRU26gd9Rui5o54yffYVO50PaBgH50Q/8tsbQ5euSAqHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvPUAXdkhIuoB9fy6yuXJcO8AC9MFx9ZQYHQJygB8oo=;
 b=dGOwjLzBGyQA4X9BJyLWBuK7A1ulvXGpmNI+nRDtL62/5caQWLfsHwMX3GEVsiCITUzMKbkcTgEpZWO9UA/qEagWaENYAFnTZsaHf8gQbNXvdA2iNtFm5Twsh8thOh8ktUP9kQnq8qB2gKmTX4ocWvd00h7XJoSA2UcxNJZzGW0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8)
 by CH2PR12MB4053.namprd12.prod.outlook.com (2603:10b6:610:7c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Wed, 25 Nov
 2026 10:31:24 +0000
Received: from CY5PR12MB6132.namprd12.prod.outlook.com
 ([fe80::d9ab:4258:a9ef:b8cd]) by CY5PR12MB6132.namprd12.prod.outlook.com
 ([fe80::d9ab:4258:a9ef:b8cd%6]) with mapi id 15.21.0662.001; Wed, 25 Nov 2026
 10:31:23 +0000
Message-ID: <85438483-9843-4b14-b3eb-57a074275911@amd.com>
Date: Wed, 25 Nov 2026 18:31:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix pdev lifetime in
 dm_test_conn_init_ctx_alloc()
To: Tao Liu <ltao@redhat.com>, harry.wentland@amd.com, sunpeng.li@amd.com,
 siqueira@igalia.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 airlied@gmail.com, simona@ffwll.ch, alex.hung@amd.com,
 bhawanpreet.lakha@amd.com, ivan.lipski@amd.com, george.zhang@amd.com,
 adrian.betschart@cinemaone.ch, rodrigo.vivi@intel.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261119054917.184758-2-ltao@redhat.com>
Content-Language: en-US
From: "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>
In-Reply-To: <20261119054917.184758-2-ltao@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0059.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::20) To CY5PR12MB6132.namprd12.prod.outlook.com
 (2603:10b6:930:24::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6132:EE_|CH2PR12MB4053:EE_
X-MS-Office365-Filtering-Correlation-Id: acc864ae-9da1-4def-057c-08df4adf4088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|921020|10067099003|11063799006|56012099006|261009223027099003|261022075727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0daeVmlgCgI9eQtBrt+CGP69vnpczr8qnlzyAL/WSlhHrx2x29RNB78PjdA85vX7UhYJW7HrpCpQSXt8IYrRFQtZWn9FeFdIgMydFe7UscHSdA6rBINOdZVlgOoZR4UkeYizWQSjaHSTlfEzrk3UY4vEMbftOP7+PSR6cRIh35P82G7w42OLS6WsXt9n5ZWafSeOoaknechFTFe+6Q8LjBnWBVTG5PQDZ1LKVyjedDFoKV8eGs4BiqR9lIwulcQYH1k0462QYlw+QXhc1o2TbTyXqGbl13mmh1Vg3RMqA4qTv2C3vkAtMLk9N2qcjy3zxvCm5kKx6fW364ZUq2d4d6qwb0zy1gobwBQ3YbqiZe/JW8SwqgUS5gXPxJRvLUYAiRdmhCDJLgSbhxmkA9wVrgC2LTH0FqQWIrJubrfMOF44dRKEds9g/guuPLeMypjzL3co39kx7c4rqtWrapdO2z+zBUhOUiMrVoFC01HvafzegyNW3m+by3ofzle1NOudanlpgaCOoB0d26mzPhRoyV5NAEhxn4i8mzStL+fkxiOfYyepzAhbgWwISOJmXD0kqlcx4n0Fx4TCh8hEw2OUovXJL7kkScPVdmZqB7b5XGmHAo+5Yq3c25OVTjoyI2dEbWfCkuKY84FhT4SNenUSJe1f4RuEL14+Qf9AF6r3FPyvH3H9iP8G6VU3NA2CxOnsB+Q3DQb20//SwqfWd06OBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6132.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(921020)(10067099003)(11063799006)(56012099006)(261009223027099003)(261022075727099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXJ4OGVROGlpZ1FxWXlmV2xXbk9DcVpqR2grcm4rT2QyZjZjRFJNN2srSHNq?=
 =?utf-8?B?NUtsTEpWc0hYS0pSajdDRlU1b1BlcjBsaFdMcGhQcXNXZmdWemxycE1WNi9Z?=
 =?utf-8?B?SkNFS0MwL2p6cU9WWTFvQVV6SFhuMjg5dS9SOUJ0U1NMYk8xU0FrVzgxSHdU?=
 =?utf-8?B?bXhhUFIzZ09JOXpsdEcyTFUveTdSYTlzSFNFWnVWODJ2Q2tsYlAxanJvWlg5?=
 =?utf-8?B?bzZBWElXd3N5UGdoZ3ZEdTVuV1hrYTR0MGJLczgxS21ndDR5dEFVVzhKNDNW?=
 =?utf-8?B?QlFUdDJFK2FidXZQZjRvNTN3eXN1aWtVUDhhWVptdmZRZFhvRmdENGtsZHBB?=
 =?utf-8?B?cnNkUDBXRys4R29aekwxOUZ2RGZ1dVQrOTFhcHFWeFpnaFJrckpCTDdpMjV1?=
 =?utf-8?B?bjl0Z244KzZ1QXd0UytMU2VZMTIrMkYySHdBSEtNc0ZsdHU2bVZGNm9NNzMw?=
 =?utf-8?B?UzRCcVpRZEZrbDZBZW1ycUFKR0kvQ1Q0Y0owOTRNQm0xTUtFeUZQZ1liUkF1?=
 =?utf-8?B?RnJ0UTg4Vk50cCtnQzJXaThWNnhrd2xubWNpM01vODlvZjV3WlhmU09ieUNs?=
 =?utf-8?B?RE00bTNRS1Y4anFVc3N0SDJKVDlEeWR5Ym1EaW5oTmxybE56eWlTQUJaSmk5?=
 =?utf-8?B?WGw3b3FuaDFkTytJckFnaUF1VlF2UktERHE3aHBuZkU2MU94TXNQSi81Z1dU?=
 =?utf-8?B?cXNNNko3T0RoMWkvN1dVaHBEUU56M2JvQmt4RnJlUGxyRThvV1J2Qnl0MmZ5?=
 =?utf-8?B?dlBHMHdLVkxZQlhGWUFCQUU0K052TEJKcE1LWS9aODBWckt5dGZKVko0dTdC?=
 =?utf-8?B?VXBVUGwyNjZBaUlnc0c5ZGc5SXArY1JjY0VuQVVaRUtlZU1CckRrZTNOT1Mw?=
 =?utf-8?B?b01aTkpXeUEzbmthNlhxL3Q4eklGa29Ja1VnZ2dvbmJrS29nQlJwSDlHaHVK?=
 =?utf-8?B?NzJqOUJvTVNKTXh0T3o3SDIvZW5Dd0dYME4xV1JpdzdNbXdjWEJKdjBOd2Ew?=
 =?utf-8?B?azd2OThlWWF0WHZJSi9nUEhjd0duanFQciswMVZVaVRVSFlKQUkvcjBhRzBo?=
 =?utf-8?B?OU4zK2FZbEZyRmdlSmpCSUJsbE02RWxaSkNUVUJOYlhLL1Vna2dJVVhlU0VT?=
 =?utf-8?B?bEc1dEFtMFRuMWtIRlBuMUtYbDFCL2NVZ3llTkVLVGFZZ05oa2M3ckVDd0pk?=
 =?utf-8?B?RVVTRDdMaUZZRmRZNk9qcFRnY0pHd0JHb1NJbzEzWUxydEd6SUNqNi9kSUF6?=
 =?utf-8?B?RjgxdzA2UkNJd3pLWm9sYWRrTzdKVWFuMVg1OUhnSWFXYUxnUnIvSjkyalVC?=
 =?utf-8?B?dGJwVDFSZmJKakdwRjQ4RTNEMHhoZ1BqUDY5ZXRoTnBEUFJONDB0eUpzbjRs?=
 =?utf-8?B?a3dsem9xM2ZSU0pmZ1FGaHIxRHRDUzFDQ0VpcHdQNzFVLzNlbzY0V0R6Zkdw?=
 =?utf-8?B?bTk4bWpOZWFQL1ZHbDB0bGU2ajhJbVlhTmpxTkxBaVlGZHQxZzZqRHhUMkRE?=
 =?utf-8?B?WWhCQmpNZStVeHZGdnBEWnQ1YW5ZSnZqWWhkdHFOQThuVXhUaFY2Mk1UY3Az?=
 =?utf-8?B?bG0zMnZZUituTWxBd3p2UUFLRnVlL0FkOGFINURhSjF5ZElrWnowOU1HeVVM?=
 =?utf-8?B?aXR6SXo3Si9vc2UwWkkyWkRQcnBQbVhRMktpMU5NeHlXSllSWndpTWwwUHg2?=
 =?utf-8?B?RU9IQmRUSUp3dTFYblB0Tm1ucjE3SUpQdWFERkVMdUlNL0s2R2JaU2pzQ2xZ?=
 =?utf-8?B?aHFWR1lYNlpSL0Z4bmFQbHE1ay9xL3dCZWQxTkNwdUdiQ2RUYlhzWDEwMXpI?=
 =?utf-8?B?TTVzMnl1ME5wRW4yYUZjYUNYS3VqaUsreElZQUQwNUE4cCsvL20vd3lWK2h3?=
 =?utf-8?B?NnU0V1RNVmorTThTZktnSlNqeThDQVFxZVRsTE94RFp5Tm1tdHNNaXlvR3FO?=
 =?utf-8?B?b2hHK1lNNEJENnR2S2xFRGF2T3BORkRzL0hrUFQydnMzcE1lQVFxckJac0Jp?=
 =?utf-8?B?ZlZUUHU0S0pqaDVjZ25ONkFOYWRKblJFaWxiQVNTYTBibVprNkF2S1o5UzdT?=
 =?utf-8?B?N0tuQ1NWR01CUnRYendwMGhmeVptU1VGTkdQaGlzUCt4QUFHQmZSOSt1bHhi?=
 =?utf-8?B?Y0F0NG5aSGFOU3U0WktoSStadTA4ODdHbVc0YjNnLzUyUkZpVHBST21GUHJv?=
 =?utf-8?B?dW55WkJWNk9rUk9ocngxUllWc3JJeHBnRzFOSXdGM0wzVkE5TmtnRUF3Nm4r?=
 =?utf-8?B?Y1h2YnQxRDNtb1pJNmpYTDdwaVJ4RjNPemJIdDB0T2tIdGtmeGo3Vjh3UDNP?=
 =?utf-8?B?QXcvVnFLSEY3UzU0cHpiRFdlSlV5WXE4cW1WOUNoMVFCRFJiaHhnZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc864ae-9da1-4def-057c-08df4adf4088
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6132.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 10:31:23.4447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+hwTVTRYmqn2x/VMSsPUplDvbck5+XvF8zf+Xyvmy1coRdw8zdrCUihJjlVxyiuqbR+KK+9rbxedI3x5uxK2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4053
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


> Fix this by allocating pdev with kzalloc() and freeing it through
> the device release callback. This ensures pdev's lifetime is managed
> solely by the kobject.

Hi Tao,

Thanks for the report.

The lifetime problem in dm_test_conn_init_ctx_alloc() is real, but it has
already been addressed in amd-staging-drm-next by commit 370bab028b38
("drm/amd/display: Add more connector KUnit tests"). That commit allocates
pdev with devm_kzalloc() on the device and registers the unregister action
with devm_add_action_or_reset(), so devres releases the i2c adapter before
pdev is freed.

Your patch no longer applies to the current tree for that reason. Could you
please rebase it onto the latest amd-staging-drm-next and confirm whether the
issue still reproduces?

Thanks,
Chenyu
