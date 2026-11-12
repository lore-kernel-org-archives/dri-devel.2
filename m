Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271F8606A334
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 06:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=e2o9RB/z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79FDD10E510;
	Thu, 12 Nov 2026 06:15:19 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013014.outbound.protection.outlook.com
 [40.93.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2575010E510
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 06:15:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmnBVUYWfqLevdkD8h8jrYC1NnIAuqbSl3TY+PJqtxHqo+X7RcNmMETOeG1n+QVIKfabJBo+uLGNA/Cjy6Afvhr7ypn0tr7d7E+tE8P4poa2fsWtwiF9U7CCz/C8UAGpjF5qHkzxYfUfh4rXWvGRuCxtvFSMuMNasmvjLRPLGfyZDvwffhJzuG0Ad7nf7SOSW1J8ZxUctHHoa+UkHCIzk9Wu5C4bI1lGSGTkKmLCQa522oMWz+L4NSOTkgeWS/DQBuOuSmMofJC4g3bFtJ1n0jqVrfrR39IjYLBO3nqGmJlynGRJ/RaLoIcKQplRaHEk0iXz3hPf/nbXzsLAGyp2Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxEQcBlNftj8zRanoA9ufrRa8EjN+z4yNK0KTJCn3A0=;
 b=ASbLXuLEtLUS9uZZOacaBNVpAWZaG1w3AolawJcrT5Wyy8ne4z5sZ13NhRXIyZAdbizWs1xtf0OW7/s+e2p5Ruu3HNiRrC9m557hS8dmQiIjWJR5F0MqFeUwM8vY9hw2Q8NvgoQFRTkzImDUJzvthKsORQXBGDu7UYDmB/htIgE/ng6hDVx4EfvU9EgzKjxkeEdYIpvVBjih0RltPFFauY1v7lduVNWgrH7hy7FGI9uD3j17qt75+pnXiB7Q6otCNPK4N51c+KvqL5q/DEB6Ln0KhjjO3AZ3ZwFySnbEH3PMtB9GIHE8WM03qpUxDxZ7tEj4dtz3ib/h8FCMRnPqaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxEQcBlNftj8zRanoA9ufrRa8EjN+z4yNK0KTJCn3A0=;
 b=e2o9RB/zxucBzwdqZOuDn3dDrIDULmYq+2zHpjSw+1I5UmcYSCc2JONOaAsey6+7YaGGYbdNtRnTTo6jhNigrjPPp+8mn0zD9/CYpqN3yqVnZOlg/hLWpKxkX7fk3lp3ADbXheMHKCaGRwJCSu88kKEqvgukFAmpRVKPpE6cr42LL3wFAsoRpoC9xKsqzyISjrr+wqrW8yneplrUZjA7Rb9X5w8X2ClP114z7+ppFZuEmEbM9DqttSDbEtZr1PD+ByQgpb1ad9pUXhOe6rytbc6Ng0dRrQycwvlug7SFz64mYBeXVu3RkFk/smJI9Fua5MQ2q5XVmfDLzmIoZqf+Sg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 06:15:07 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 06:15:07 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 12 Nov 2026 15:14:53 +0900
Subject: [PATCH v2 1/2] gpu: nova-core: gsp: cmdq: wrap the sequence number
 on overflow
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-msgq-64-pages-v2-1-bc1e6f7301ca@nvidia.com>
References: <20261112-msgq-64-pages-v2-0-bc1e6f7301ca@nvidia.com>
In-Reply-To: <20261112-msgq-64-pages-v2-0-bc1e6f7301ca@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: LO6P123CA0054.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::11) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: dd1af087-c518-4c75-9ce5-08df40844c32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|10070799003|1800799024|366016|18002099003|22082099003|11063799006|261009223027099003|56012099006|261021123027099003|261021121427099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: gaBhg75e5kaDb+y3ec/ZyETsbYVscyvdVrPZIn25wVOyjDf3VQO9m/qU195lvHF/ql+vP9BQxeMsdi9WLRz5o+D6mdwlD31NCtfm6kazqkCZLbJvlaokhkDtNf8VkoXxcsE/IsY3dgYLmuZXroJei9gdpJosBAzY4LFEQGfXnLF3VS0c5bHpo5nFAV5NC7E4bPQB2WuLSTDpFHZEFz6sHL5lV4iJpM4+xE6PKHE6hoPcpyGWronvAFPPMFFr1tT4Bgu/lHLxJWUyoL0pnXXEmQUiBhBsKZ8R9QTUzWERmHP2ShyPoPgnUxI+bUJFtc8A7KpXnY8QtMV5t6o0xxV/vRoNFakIiqQtbwm4bYFaRwtHuZxnsWayl9kbivOYgZylEThuKXZohuZW20DL0WXNMXcp00hD3SwHMZQd7nCXwEuLoBMIbK+nKloTwciAyPJkoHcM5GBZsDTW1JYz10b0ODo39XRqlgwpyEDAYmonWKvux0FpGs03VLUx50WNmsCTSRt53pJ7yxXnTY8XzCg5ZoAZmpxGLPdZMs7KL8xyti+mlyK9rtHA2oCTU5BOuLcm8Iqg8sNcVDo9V/XEFXy2oJWMtEYM57BNxCuzeCvUipqsW/Rg6bDFnQ7f5Q0CriSHo8KZrwS5Lj2/bhSB/y1qIzzRtMUGbWA/yayXWgibKCg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(10070799003)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(261009223027099003)(56012099006)(261021123027099003)(261021121427099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1duUDVmOEtLc0ZSd3Bvc2JSZWRuSVRpSE9WcVI3d1BMR2Q5ZitTYnFHR1lY?=
 =?utf-8?B?TFBjYUVoRG83VWhGancrNE9NdTZFVm5QR3RLRUFLSDF0bGUrY0M2YzBHMC9t?=
 =?utf-8?B?M080SjlkQTYxTkowZHgwd2prWlh3ZlNhWW96RjF1OUFwMFh0S0VLM3BwMVZ6?=
 =?utf-8?B?aVVJd25VVnBvMnRzUU9qY3hjdU9mL1JiV3RtczU5cUlpdDVRQTJGNlJYVzJo?=
 =?utf-8?B?WVd6c2dsVTRKQ09xdEZwLzhvRjJNMTFUQllMcFhPMFFGeWdlZnZDVEhjcGdv?=
 =?utf-8?B?K1MzcmwxNEJPRkFZM0lMbE9hN0wvdDIyalJmb080WVoyYnV5c09hNEdMMURu?=
 =?utf-8?B?Y0dYbnlucXc0V2JnL0l4QlR1bnpWZjN0OUVBOFlCaldoMnlMYXc3TVZzVXZR?=
 =?utf-8?B?bXcrL1phdTFTOE9iS3laeGJqU0hxZnliYmM4NW9TQ3dTSTRNYXRpeHZKajY0?=
 =?utf-8?B?TFhOOHJyR1ZxeDNIbE5WNXlIRVJtZmZLYUREQVhlYnlidEpwYVNZazlnOGI5?=
 =?utf-8?B?bncxMlhoSklPZTFXSWVNY0h3M1lTNDFJNHMwZUVxRXdLU3lQWjZYSk1lcUY4?=
 =?utf-8?B?UWZ0elVHeldBazl2RHVXQnJ5bHduTDJTMkNuNVVtQlRXZEdvRjk4ZlpTcHYw?=
 =?utf-8?B?bGJNSnFreFlaSDlaRUF5NkYvWXRheXBnSjhzcjRQYXBUMC84dHJ2VFFPV3Ar?=
 =?utf-8?B?c2RjcnlLdkhTQXRYM1poTkRXa1ExSGhrdUZ0WDQ3THY5RFhJaHVvTGVxOVpz?=
 =?utf-8?B?SmNFY2JRMThuNy9NQjVpTDdZYWZoMlVwMzNHNllPaDdQcEgrMmlxc1JKallI?=
 =?utf-8?B?MWZQU2RVZHN2elNtZEpCZGNvY0doOWd4ZVhBMmttOVNFZFdET0lMREZielpN?=
 =?utf-8?B?Nmxwdlo2WGVJeCtkVURtbTN6SUpZOVBVR29lZC9GMmZnVEdTZEUrV1F3YU0x?=
 =?utf-8?B?RXRSQ2E1T1F4L2xnUE02R1Z1L1A2RFNJUCt1eXpFTE9LVEtWQUZPeStySmRE?=
 =?utf-8?B?dmhYY2kzUzhpOHU1NFVQVDROSHQ4OVBzSThqcDNIajExSGQwcXI1TGM2RUJJ?=
 =?utf-8?B?MHprZWxvekRubGpZVUsxT080WEU1Uk9QanJ0b0poOWhpY0lSUGhhMVZhZ00x?=
 =?utf-8?B?cDl4K2Q3UDNuMDNJK0pZNjJubVRGUUNKSm1uMGt5cStsSjFNd2dlSGtCdWJG?=
 =?utf-8?B?ayt0VmJNUHhEdlFVSW4zOHhBVVltbytCOEkwRnlwVmNjcW9BK1NlNlRGeTVN?=
 =?utf-8?B?OG9QZHdoeXhFNFVaRS9vbGpTSndpaXZGNUNXSzlHK0FRUEV1N0tOa1RPREh5?=
 =?utf-8?B?bXBxUGtLY3NHWkwyRTN2My9JYUNzTkRkb1JNN3RzQ3hjeDFoMkFZeGxyb1E4?=
 =?utf-8?B?bXFWRUFUWU1tRXY0bGRTZWFrbDIyMzE1TGw1Y0xWMGxPb0krdFpDUlJFeXd2?=
 =?utf-8?B?NUF3U0l1YzVHMlNVS3hPaEJONndiTlhLOG90MVJVeGpKeEJyVjI2SUdwMUEr?=
 =?utf-8?B?Z2dvbmVBaDZRYmlLeXRwOXRPayt0WEtpdFBsb21ZY3Zaak10bENpcXB4UXBs?=
 =?utf-8?B?eDRFSWpJRlpvdjFhRDk4dlRIOEdTeVUxNkpBVHRqaTFiL0pRdDlxL3dnUWNN?=
 =?utf-8?B?UDJ6ejZyaVBFd1ZrVnB3dzhSRm4wckVsSXBEY2lOZUNEMmRXc1ZSR1kxazd6?=
 =?utf-8?B?QnhXUkpKQjkyakU4Z1dIeFJyM3llSHUvTHM4MlpnWFhzcDJRNzZHL2ZLQkw3?=
 =?utf-8?B?RmQ3VG8zNGxDd1JlNWRJQXEvTHdVbm8vb0xIbW5XSzlUTEIvRzYvTm5Qb1Ni?=
 =?utf-8?B?RjAvakE2ZkFuRXB1T0pKQTlkWFdIWFZ0U3o5QnRFeUN0cVRYOVFYQk5WN0hY?=
 =?utf-8?B?aGEvdzFGYTB2Q20xWlAydU41SUlzSlhIT0FhS2tPdXhZamc4UmNKUjhJNVZG?=
 =?utf-8?B?eWJUU3ltalFDV3A0ZlRrM2dRaVNEcXdMMnZIRUdVMFJubGdvS0lBVG4rVGcy?=
 =?utf-8?B?ZzZUZmlueHFxaFl1Wm9Edzl4MHo4bDVUNDh0eVRMeG1wVXZrcDNrY2p6cE02?=
 =?utf-8?B?K2V4ZDdoZWd4Z1VzaS8waTlLcU5FVU1wRkR0Z3FZTUZoc0ozWnAzWG95dlRt?=
 =?utf-8?B?L2JFd3R2bGZlMGtHRHFUVXVGVmlXcnpoZ25KTmNMM00xM09oZnBUcTFBbXNI?=
 =?utf-8?B?T1RFSVhVL24xdCtJQnhNKzUxNUJpMnFQNXU0VmdBV0lJVVBGVlhway9SV2ZC?=
 =?utf-8?B?TUdZQUhUalJTREc2Y3BZQlhrU2s2UHpIUmFjQ2ZKS1V5V2tqcHRFNFRGdVRi?=
 =?utf-8?B?QnQwL0FEYk03YkQ1UitZcUFVSjEwbzg4bk9Cd0FJdExydGN2VS9ZVGJHQWVr?=
 =?utf-8?Q?A0QCQU18/oQFrdlcl1c+Beup/vZy0hrdajMJkU2YdOCtk?=
X-MS-Exchange-AntiSpam-MessageData-1: HeQ4y+e+gO3U9g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1af087-c518-4c75-9ce5-08df40844c32
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 06:15:07.2889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLpCIhYK2zQVOc13w4fOgJXUoZuL+qQ0itqBscKfUb6eN474+77gfegqLS/JCV6ooVe/lL3+04qQZnNff4EqIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The sequence number can (eventually) overflow, in which case we should
just wrap it around.

Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue bindings and handling")
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 5f3de456042e..33074bb53e8c 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -578,7 +578,7 @@ fn send_command_element<E: CommandElement>(&mut self, command: E) -> Result<u32>
 
         // All set - update the write pointer and inform the GSP of the new command.
         let elem_count = dst.header.element_count();
-        self.seq += 1;
+        self.seq = self.seq.wrapping_add(1);
         self.gsp_mem.advance_cpu_write_ptr(elem_count);
 
         Ok(seq)

-- 
2.56.0

