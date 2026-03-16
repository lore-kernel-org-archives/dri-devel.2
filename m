Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E0BF53D82
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 17:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A700410E211;
	Mon, 16 Mar 2026 17:57:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="tgJKMJ62";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012044.outbound.protection.outlook.com
 [40.93.195.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D52D10E2CB;
 Mon, 16 Mar 2026 17:57:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtSuHkkt5oIVeyjLj0S1kgTEYLZe8DQhmVtywWu9UYQISijuvqdlX11GzJiCzMPI6ZSLKe8vK9QKlx5CKM3MWS/BlwhyQVLoEPfi/5QnaNY/IvIyq2rconBL54q/xHrWNFoGwFRqxjPGJ+xNB2HVx6qZFJyOMkgI4znfL1AnHQVTFNOi9dJJlR19coZg/pRKnQcUIHw60LAYDcxZ2/TaBlMhuEjjPGkMkau1es0+ImV7/h79xjE/LgQ+0uPcngLhGOYw/8fRFpvvJxJtKWId718/Q0FP/SW4BhOtAPl+O01UbVJoqSQskxI+MsHAXREg2eX3uAIvJhMZPs4++X1mJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdRMZsbEySH80oNG3rWauOIaKlxgklJK/cQphje+4/s=;
 b=ys5jpIhQGCPzGWm6M5Tvkvfl+RvACHV8+ixiVdP7FvIY5TZdwCVFw04/515YCnY+H1AWQcP93pUXPI4nfWb5DE6LUDz7hbLGNQS7hPxWQJMQh6S7CIubekXR9vG2EgRaYczq/qHZPX70/44YQc7nKhTgMU3a/Lc8H6RbRQjS6s7NNwi9WeoiOEUT0qAb26lJ7nylsasRRIunjj3xiFYM8CH5ViHIG3y1dZa7A9jKvN5eMFBzF0YiLF96+WwYErx7FsNPooERo3vFqYH6CvPkje9TcGZ1PmdfztZmyOoNEeFHAmzEPSNkoJ9Cw/CgURm1D/EKS0pdo8RL1fOqsrS6EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdRMZsbEySH80oNG3rWauOIaKlxgklJK/cQphje+4/s=;
 b=tgJKMJ62gbcRWxHsNpHOmLTTyegrzaKZnccYrf5psJGR/Ye0V/xMC+t0LDK9T14lESnETfrHkP1+NnL2jgib2eSPnYtEsF9DMYXX8kS8mXDv+wTxjZMT9EnOP1t7uDFlaQXBU9ZHXrPp5AswjRSmTtXoc8XGYPVwclzLGQx7C7T+vJAwgz0GyvUA0qLtYUAsxPKan+hti8+wZbg1EITnxMvn8iEka9/oExTvo48rxN5mfj0SXfxkz4YfR9BnbHBxHghfttCKIhh4vOQCM30wFBMtlpaaMuCo++sjCM9zySvWiqb+xofee7W4rbZ4PxbAgV5t4sSTHFCqP0YrNxjCXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 LV3PR12MB9438.namprd12.prod.outlook.com (2603:10b6:408:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 17:57:13 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 17:57:13 +0000
Message-ID: <2a914258-bf58-4b46-99a7-d8c76fe52671@nvidia.com>
Date: Mon, 16 Mar 2026 13:57:11 -0400
User-Agent: Mozilla Thunderbird
From: Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [PATCH v12 1/1] rust: interop: Add list module for C linked list
 interface
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Alex Gaynor <alex.gaynor@gmail.com>, Alexandre Courbot
 <acourbot@nvidia.com>, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
References: <20260306203648.1136554-1-joelagnelf@nvidia.com>
 <DH12CMFJNDMF.D3F50HV9020X@kernel.org>
Content-Language: en-US
In-Reply-To: <DH12CMFJNDMF.D3F50HV9020X@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR06CA0011.namprd06.prod.outlook.com
 (2603:10b6:208:23d::16) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|LV3PR12MB9438:EE_
X-MS-Office365-Filtering-Correlation-Id: 1708e9e2-5045-4943-b95d-08de83857417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: wE+4SyrhB+n0f/i0kfO59aFoL/iScx85x02euBrDDunFfLtmUPgSJ+aolZSi3k4eKt06dSzLvMW6YWCoUlBspZMnZC4qaX42xuSFxmn6ZgZVuMkNet6fk5wlRcjobqOkW0A4Pw9hVS5sj9z5FXqpkilQ8chjCDbN0Q9XtwZFHiU3wIXmGqKqRfrXSwk9rRpMRiYDsjcNmXkBkx2gRpVVB+vPDEZnWpRA8jYSUvirUjnjlOsSk0ZG8ty3Qvjo0oWbnjhXJVgfcpL2fnvp99i4KacBqErmt92/kpzm5rAlojy6SCj2xnQ8ZIWi7q1fqdOs7Nn18nao2Lq2vSqO84t7XCD4x5ueFXOtkhxc7nymXQUJD6bCZU4QxWCw1dLr43b0CvPdlGN1no/2MqqSTjIMyvh2lzr9u6bTwIi+cSA9Z04XziHS+d14cXBgoEQgosdkdKuN3jYnqu+jGGKCdWbuIpGoNdecrI1JBl+QgX0aVF2FU2asNK6oW2l0TEkHbrusXZSGmDOoJLNMPstfhVo4W+XwxOSZRjNAlpF3BKKDsbPs9o6XE9tnnzv/iUM20v9xmp1ef4Y2SRv4jkIKltnVSvws13lWQUOkONYxI2vJZ2VQNLLUb1Wo1EY1fq04sNlNJpVT4zsMaIRgsSdPFt/uWAoxXjkrUkKNJdODrVULiSe5AioQBCeVGuhJtIEANOXeCybQ9tXiYyi4cAggDyscY2JtvS1hBhdTZivYGvzCNp0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWtvM0xVL2VwMGx6S2VXQjFFWllrYlRoWStrMHFoUGtEVnE3OXc0OG84c0hE?=
 =?utf-8?B?MXRnbmt6eGVuZWRqaW5wYzFiTEdpSWYydVN0N3Z2OFRyNUNmRk1JbGFBbDlI?=
 =?utf-8?B?T0pZY3VOTnkzNjE5elRSa3BrVUp6UDNtMkxtRDlvdUtNM05Vd3NMTlV1Tmhv?=
 =?utf-8?B?UTRTdmxRUzliZ2xSUUxqeEpLZjcvajlPenlPWCtJTG5mVVNIdXFtNmF2aWxa?=
 =?utf-8?B?YTNSRWZ2YjdidlRhb0lWaHlrOUFsMzlINlIxL1YvNjU5TFVFUGxmTTBxczdl?=
 =?utf-8?B?TFhCM2M4V0Z4MXhOWTJZUTlMcEZJR3VqalByL204MDNYZENOZ0QvbXA5Mkd4?=
 =?utf-8?B?cUwreFozQzBrcWM3elMyVWUzekg0WHBoUSttaUU4RHNxdUdKNklOcExmNSt4?=
 =?utf-8?B?V0RiZFNodzlWcG1wRkNiOHBPbGhIVUlSTG5mTWFJSnVoMUt6TXdOc0dvMEQ4?=
 =?utf-8?B?RUEvSlU0enJ1QkxmdGtPOW1seElIWVpQRUJuNVdkK0tDcU5nUnBiaU5iUkRp?=
 =?utf-8?B?NWYxV20ybWd1TEl3MHoraXpHanIyb1VyczBUb2JOdGVRM2c3UldSN3BnNTJX?=
 =?utf-8?B?QXpYZHV0NE8rOU9USTNyaUdHZHBoVlp3N2srOS9GcW1OSmNTajU0ZVBrdHQz?=
 =?utf-8?B?WmtGM2xobnl0T2ZXWTg0UDhpOGdlZ2NwME5rbkszSnUxTlA3Z2ZOSU9TalV4?=
 =?utf-8?B?eGRwQWJqWEdWSXNPM1pzd0pzd1QyYUFzWXBLQ2tsNm9OK1NTeEZVVXB3Vjlz?=
 =?utf-8?B?NHh1dzlxR3laVklsS3VIdDAxbTRsQ05UYUkycFhKMXYwOHBaOElFWW8zcXNY?=
 =?utf-8?B?T0NmU042UGY2MTNHc1NXK2NGUnByQ0Q4YjFZUkZiU1JFZkhKQ3ZmaGZJUnJr?=
 =?utf-8?B?WjdHRXZQUlFrY3o5OTJHa2hxUGl5c3BUTktwWURsMmFjSlVtd0V3eEszQ1RK?=
 =?utf-8?B?N2o4U05pMHpTWWJYU1NCOHg4dklsL2xvOW9BZzRpNWxqNXdIYzZjOG5Sdytr?=
 =?utf-8?B?UzE5MGNEMllTQlNtb2RTeDE2SkE0NUMxSW9xVDU4WnI5OUpzajNZT2orZ0xm?=
 =?utf-8?B?ZzBGek1YUjUwZ2FWTTRtU3JjNjltdk1TNnd2cGpOTFNaNmtrR1paalI3TWtw?=
 =?utf-8?B?RXU0UUhMZ1ZzRXBzeVNVVWtieE1YVmUwNGNwaDdUUGN5V01ZVXNSSjZJbkgw?=
 =?utf-8?B?bTY5dWovTlZhYkV5N2JpZkdwSmZlZ0lwRUViNkoxdm85UGhFTzc2RDYwWlUw?=
 =?utf-8?B?SklaMjU4b0EyQ25mb1lIdm4wK2w3bkZTZTcxOFk1cDFnYlVZbEd2ci91SzJj?=
 =?utf-8?B?WUdVNjJKYTdJYytkTlZvVVpjM3FSQXNFVjFXbzdmZ0NYSlh3RTlQTzNlWm11?=
 =?utf-8?B?dndCYy9vSnZZRFNCWlkramZqU0VTUEhnZWE0VWVzQjVIcDNrQVZ2cWdnbTh4?=
 =?utf-8?B?ZG1XTENvc0hwMnlobERkaG12N09tdkxrUVkvRXVpU2NDbTlJM05zdnFObU5y?=
 =?utf-8?B?Nk1RZFRKcFdMTXRnMDRHaTdpcEVFZGFwZE1IL0tYak52SUdMUE9lc1FreDhL?=
 =?utf-8?B?SDBxSnpqR2daSHVObE4zNDFSTWZSRlFOZGM5aFdDeFk0R1BHdERxeGRrRmxo?=
 =?utf-8?B?aWsvTGUvNzBhZzZDZzlZU1FzajR2TVppV21yWWpUZTR2cGRrSFVoS0NPL0l3?=
 =?utf-8?B?bW12ZW1iMnBBRjhMbG0ycTJuVElML0pOV2lWK3R1bzI3Q2VCaU0xVkNKNmt0?=
 =?utf-8?B?RHNZQUVKZlhoU3ZTdi8weFZOZ2JBOFFLZnBoRFdjMzFNWlhZMFVqNzFzd2dO?=
 =?utf-8?B?TE1WenFhQXRYTUVDSS9selFza3VyY0JHZzNHOEptNzVSRDBrdURtK2k3UUVl?=
 =?utf-8?B?QXpwWFBDTWlYZ3NxSGZhVUpTMWVzMXBhZTdxVk5IckdnRVlRODcxYnpIYXFo?=
 =?utf-8?B?Q1JSMU4wVUZSR2ZkUE1yZCswVEhad0x6cU5mYkkrUkNtK0NnbFhOL3ZFeXVY?=
 =?utf-8?B?U0lrQVAySHNTY0VLWG41OE4vRWF2WENKc05ZWW1Kc0F1ZnVod0pSUWVTUWd0?=
 =?utf-8?B?NkdhUWpsRFpIUzJxa1VVVGlGSjlJK0xkVnE3VzlKOVB1VkdOUXNiZlM0aytF?=
 =?utf-8?B?Y3pydTRHek5vLzRnK1plcU82d25tY1Z1cjhuRndlUHh3Sk1teGJCYnRNY2R3?=
 =?utf-8?B?Vm1UT1d2bTlKRDRHUm9Zb253YXlxWFpiZm5QU1ZqY3k5R2Z2RkJvNnFYamxH?=
 =?utf-8?B?aGFEZnQ2YUFzSTI5dlV2azZaNzJtaGR1eTBtL0Q1MFpBbkxQTVk5RDUrNXVn?=
 =?utf-8?B?UUUyaHBUeFM4L2J4aUxUWW91N1JBdVFFb1FLOHcyS2VxTXdrR0V3UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1708e9e2-5045-4943-b95d-08de83857417
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 17:57:13.6233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBgN9UNd7FjTKYVJfeadGTLKXeJbDuuxjvOBgLCzAiKpbadxwbYUe124TuTNeFt1LcK5c7nQ0QoWRTb2fci3rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9438
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

On Thu, 12 Mar 2026 20:50:34 +0100, Danilo Krummrich wrote:
> I did not give it a shot yet, but given this and the other nits, this is beyond
> what I want to fix up when applying the patch.
>
> @Joel, can you please resend?

Sure, I will address all of Miguel's review commentsand send v13 shortly
(probably by tomorrow).

thanks,

--
Joel Fernandes
