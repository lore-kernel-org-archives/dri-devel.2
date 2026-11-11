Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDBB606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 04:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=I576QHSu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CDFE10E089;
	Wed, 11 Nov 2026 04:27:45 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011046.outbound.protection.outlook.com [40.107.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CEAE10E089
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 04:27:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySuJTig6qIvk59zMmBD2FaNqIfIPhE33/TfNdNk9Nl75b3v033uWnFADct+aLRTBmbKSdjbdYpADqfD2EK0QwIsnsLHrMyqnw7OOqUzc5MppWOCT7AymSvNl8d6iOj5FmKP34KXmuYk3uz6+MoMr31KAmbTfhyF6Ll/a9pfHUkFQhuNWsm05H0VL86l87x2F71+nbMdE/zui0TCqFYwA00hhuT8CCukhtlMp6YGJRpjzt4OQyUjyUdGT/kDddZLHAUMTkqtzeueFDUDyY2xDGAO77dGJAwGhDFEPQiwxBdgQBlEWeXNqaC4vRj8YlFJcODoeNHu0iaSv0UPgz74SqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aZGN986XL2qgB8m6/Xb19LHpdIKFO1rwFf8+vu7PR4=;
 b=RmsTpXu0CtGEjgD8HKisznRZtdp7gEPGqg6j0gmFaBPonapFtbAy55wcn9sJCRjg2GawV/1wqCPeS4fYzx0CMiNST4QHlcoEBXn1Rj2ArA2u76NwGWRoS/DMIEmcnopszvPvNiY8ji2omaiPQQBpK/6KjtPp3zwLv+1J2L5RLBnRK8reubjNvOPeWzkScwv/V3jk6jMsdFwfLDvvvYnReMOaPLTLYGisUt7pAdILyJYp9zy/O0OANk6D+o4lQVskLkG5YsFXz3l81FGAZdRHgP5GZi3hw7G2Thz75BJEK8VSovaFQ3xUWlNPPgCwWyM457c2OkYAwyUtwK+HXZx/3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aZGN986XL2qgB8m6/Xb19LHpdIKFO1rwFf8+vu7PR4=;
 b=I576QHSu0o7BOccPl4Rl/X9B3ieLlVyNNb+vHOUsC6eDELmVzOUCzkSfM5DN54oBPVmhmhlePj3WUYGSiWBSV2kEXPwU1I6o+s/evb3hmxdQBt1gycecu+TXM65JUf+buh8ZXTY9Vb+ETzokyNanV4LplbZtc95qetifx7SdFYtQDVlarOGhZV8Nz2W4/tzSVNACG1TFkLa8Dk3yCGn+KB/9kMr5l3lb8gypy3P8VE2FBjhEN8F+Nc8X+gWR8V+cU7SzIRJLGjURCCMNDj1APSnl8zgdZTDLzcS/Ukkm8qdq3DCoEnGiu0rHQdq91zdU+HsyEe+kU20Lx5/juYmE9A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH0PR12MB7863.namprd12.prod.outlook.com (2603:10b6:510:28b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Wed, 11 Nov
 2026 04:27:29 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 04:27:28 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 13:27:25 +0900
Message-Id: <DMS3IQ7WNPLQ.3NZ341T54H8FP@nvidia.com>
Cc: <dakr@kernel.org>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <alex@shazbot.org>, <jgg@nvidia.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <jhubbard@nvidia.com>, <apopple@nvidia.com>, <joelagnelf@nvidia.com>,
 <ecourtney@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <kjaju@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>, <xinmengs@nvidia.com>
Subject: Re: [PATCH v4 02/32] gpu: nova-core: gsp: pass boot context through
 setup helpers
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alok Kumar" <alkumar@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <cover.1793906667.git.alkumar@nvidia.com>
 <84b6a7a0ea19beb962aac6205c6bb03881d1eba4.1793906667.git.alkumar@nvidia.com>
In-Reply-To: <84b6a7a0ea19beb962aac6205c6bb03881d1eba4.1793906667.git.alkumar@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0164.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::19) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH0PR12MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: 5892e461-5354-4e77-9b7e-08df3fac1855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|1800799024|10067099003|18002099003|22082099003|11063799006|56012099006|261022105027099003|261026140227099003|4143699003|261028144727099003;
X-Microsoft-Antispam-Message-Info: 1udtfNqBm48EH3QTh/COTF2tZxGSMEKqI87iW/2d8d8/FCFBmhNI3CjDzUOUhWCN1F7UpnbxTLK4dSULg7u3Q5yfrkR9E0Csc30VTgtDYSvCEk0bs5pgzyjVY62hd9O4ex39Ieee6lDTrqBIgTJtebytqJVm5BacU175iHF1XYHDW20+ErdzMgRrwkNVySI0hXfAHVcOJYbyG49OBajToEVoUN+ttuLBpU4NIecgPffsEL4H9IiKRxtp2Dsca24kZKrOCTvo+swUtGM4zj2hIKbvvQ9Ekh6agyDtOb/UZmZ+S/buIJPSDmB3DM0KDWOLW6yZ/aQ5xg/9E8TZhfID85oLoR3e3TUeaQG20jJOCYXbTDb8dZORd3TFvtn81L9tOUf6kiSVk8mzslGKpreGQPYNOt7JgOMAajhkIODQc/Wf9bjjnnqZaB3nEjNfFRVfkkQW1lhpUAzTh2DFUpG0MAV4hYprGiS3IIeF+lGZkJv8bAYiZCZ4C9DGO9ivClp0Ok2YLlFX+77eYoZj9aM4tIeWP2sorQeBYfQBRVSok+cgBYRVdaZ118Rklbx4P6l3CPooDYhlfDfIwXso0ToKSnb6jJRhOZsevhRYxtU20eFvYcobdZTnAQ8SJpRUYlQp6w8pFzlEoKAHJS5/1Wo+IfuOQgeRrGHWoc85BHK0n4I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006)(261022105027099003)(261026140227099003)(4143699003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXpuM0xaa3lwa0g3QUFnR0w0TnZxaE91WGZWTUVrejVIVnpJZ2hRazU4ZExS?=
 =?utf-8?B?VjNabFJ3Mksrd0d0dUx5ZkJSWmdiY0JSWWEwQXFRdm9tSG5yYW5ydzh0dUhJ?=
 =?utf-8?B?V0tDNCtMMVJmbVI3Zm4zamJoNG1YcUdkYk1laGkxR0N6dG1GdkJOZzd4dU83?=
 =?utf-8?B?NWQwWG9TanZvMk9UZ1FNdUFraTc1VFdsTDdzQlJjanp4dXpTT2RFMTdsWHhB?=
 =?utf-8?B?MUhLQTFCdDhyTnlneFZ5VDhaOHQ0UVhFUlJ1SWRPd3lhNVp1cjRRNWtsTlFB?=
 =?utf-8?B?R1F4UW5BZVcrcWJHdlYydkFqdlNYNDdkSit4Mk9ZZk1Fc04yU0R0eE9PRFdh?=
 =?utf-8?B?Y1Q1M0dnWXVCZVNiRVpTV0ZmWnJZQmF0WURkY0p6cG5zSVUxMWJtcHNseGdk?=
 =?utf-8?B?ak1ZSVJiN0puNHlGN2xsT2Q0c0cyRXdRSTZqcnMvSWxpR0R1UFZhNWxaQnZJ?=
 =?utf-8?B?OTdLckZBVzFhMWZ2WVlvcmp1eTA0NGhuMkdYZjFjWlh2UVRHb2ZUSUJINGo1?=
 =?utf-8?B?VUwvSkQ0ZTBES0YxOWFSUDBaNHlzVkdhQjFXT2FOS2tBOUtSL2ZjdXJDUW5O?=
 =?utf-8?B?WmYrb0RDOHg5WHZVVi9PMklsVFVLYmZZcnE0SDl2YUJQVlowbHAvWjUxVEUr?=
 =?utf-8?B?emEyUVZHTlUvY3lUSHBRS2s2YUVoTVdMZ0hubFZRLzZkNDU5WHRFVkZvc2tC?=
 =?utf-8?B?bXFJZVpibVordDRLcGRjb2prMDhHRDNpbEhtQXJWenZ2SGl6TFR4R09HWTZC?=
 =?utf-8?B?Y0FiMjZKallvaVh3K2xqQXhTdkc1ZUhEOXp3S2hCRjJSWUxJVkt6VkRBWG50?=
 =?utf-8?B?M28yZXZ0TUxMT3dtdTNaazFQeE1xS21PRUJmR012MWJ6Nkl6SzFaV2tmZW1C?=
 =?utf-8?B?YzFubzg3cXVUYmJyZFd0M3hnVGx5dlV6M3Z3eXdWM0pEblkyOU9RYTRtVHVx?=
 =?utf-8?B?NVh1NmM0S3lGdmp6MG41VU5pV1NPM1Buekt2RkRUdWVZWGZ3Y05RdmRMa21C?=
 =?utf-8?B?MjlScG5ucktreXhFb1NkZmZUbG1VajFPaGcxQXcyZGdDUkZ6WFZUMVREbndF?=
 =?utf-8?B?MXM3VE1UNlZIM1pLQTJyclA2eEJUZ2szRXoramh6UzhmYmRmQVRFZkx0cUg1?=
 =?utf-8?B?OElvdXB3aVhROG1LaXRKMFljUkdrZXlqbnkxc0tDaUwvdEU1L3BQUGhYem1M?=
 =?utf-8?B?WTBWZktmSUI1YWlsWnc1ZHZNdnNIbXBDTnZBWFVISU12OURPUlFBN3JiMGIw?=
 =?utf-8?B?VnBnL2pKOGFDT0NscHBOZFEveitJUHVDUFZXSVhTeTlHVTFLUFpORGpGWnRz?=
 =?utf-8?B?UXBsQWcrS3ozcmM5MEx3bWV5cjVTclp0bEhTeXNqVm1hS3BYSkhlemNqeFFs?=
 =?utf-8?B?S3BXazVYQTRUeEN5b1RzSFBzcmVQMjZuOWJ6M0FseXpiazlpMFFPcTFZVUhP?=
 =?utf-8?B?c3FkN0dsK0k2OWtiWkVJV1k5ZHk0eDdTbUZVSmU0dFVSU0NHL3lkaUIyd1Ji?=
 =?utf-8?B?ZDJ3b09KOVNwdUVZUUVNYUZ2YWphaHJnSVNYNWpiNStRNWUvSDFZbUt3czRS?=
 =?utf-8?B?dnZZeThMRVNTZzdnSmg2T0VibzN6K1FWUWgrM0ZNdVZMblRraUVJdUZYWENm?=
 =?utf-8?B?UTJrV2JuWmo5NlBYNmcxM0lQbWcrakdmZGZaNGVvR2s4L0FmRnZuOGhzNzh5?=
 =?utf-8?B?NFdQcHBaYUtrcW56M3NsSXNYRE1ndEVUTmJQQjE1ZUM3MkRRQW5xNUxWT05K?=
 =?utf-8?B?WCt0bzRZaTN4cEdJQUtYSUN4RS9JUHg3N216T0F1cldlNisrVDZsTnBYZll6?=
 =?utf-8?B?RkRhcFFaNWErbmlHaS84aVlQN2tub1VkREd2R1dBTWNLamFkVjRrTnVyZXlK?=
 =?utf-8?B?eU1OUmZaQ1pWN21jQWo2aVBjWEhQM09UVW01VXRZK0I0NnNhTUdkRFB5bG85?=
 =?utf-8?B?YWQ5azZ6QnZTYjhnY3JlcjA2VzFhWlFMMCs4MmR1MEtpdklQZzhyVXQ3NlVO?=
 =?utf-8?B?MVJ5b09aNDBXaFg5UjE5bFY5VEt6UmlNVFNLRHZnRjhMNWxKd1F4RDc5Uml4?=
 =?utf-8?B?dUc5YTJVK1Vyc2FtK2tFZ0pWRG9BeE00aWZzSnFOY0YrdDArNU4reFJJZkxQ?=
 =?utf-8?B?cFp4aUV0Y2R3eFRSY0ZBMlRZVWFqcUw2Zm1PYXFCMW5yMDJHMjFPMnIxZkEy?=
 =?utf-8?B?WS9Qb0N4eWtIeFhLZjFMR1NjYjlkQXo1b3ZOMXZlRFp5TFpYMUU3ZWxDVE9w?=
 =?utf-8?B?THJQRE0xRm5ST2lXejk0bDJYUnZyZ3JCSlZzczZyeEJVNE95dk5sM1BzeUpp?=
 =?utf-8?B?N21jbjExUUc3RXhRWnZPOUNmTW53eGthQWNtOElrMENDOUxiclh2QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5892e461-5354-4e77-9b7e-08df3fac1855
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 04:27:28.6809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iyVaWuA5KkY3fBteCG/QpDm1krc5PPPU6bJjmhasaeMlGpwDhhAXtBHtUs6QrmOCSPHY5YDBTc+nqd7Qkr/EGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7863
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Nov 6, 2026 at 2:39 PM JST, Alok Kumar wrote:
> From: Zhi Wang <zhiw@nvidia.com>
>
> The GSP boot paths pass the device, chipset, BAR and vGPU state to the
> VRAM layout and GSP_INIT helpers as separate arguments. These values
> are already available in GspBootContext, and some are forwarded again
> to the WPR2 heap and VF topology helpers.
>
> Pass the boot context through these helpers so each can read the fields
> it needs. This simplifies the helper signatures and their call sites.
>
> No functional change is intended.
>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Alok Kumar <alkumar@nvidia.com>

Makes sense as the GSP HAL methods already take `GspBootContext` anyway.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

(I would have merged it directly, but this depends on the r000 series so
marking as reviewed for now)
