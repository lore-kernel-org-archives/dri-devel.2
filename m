Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341A0C54FCD
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 02:19:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F83610E58D;
	Thu, 30 Jul 2026 02:19:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="OJRek7Tv";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FFE210E58D;
 Thu, 30 Jul 2026 02:19:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CSTGi6QpKJx1Efgi0NwPlc7kk+4rjvtWUtnuBTumGVyD+yp7LH19xf/EY+SKbk50BCG0TY8EEs+6KWynrWezfMGYAhj24avKTaPGMQCrvGf7C9BDI5JQrp9z/yeXXzklGFw3SeUyTj3/i51e06UjbQN6btza6Y3Y3baOrL+jzv5ZSmCGESPOnTxnli5gzGZy6jqw0ZMN0HFpnFUmOT7pS6oTsPE6qx8KrGiKjJ5NcK6qBOisLvhaJAQsZcq3rCJ6xIUxtTTU8NDNLbYaPIL8LIz1AflqASnExUhoUeTY1BEuRw2+C854xT63UW5hbdXxKYo8Og9vf4Zj9xs9n8PnxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LDIby2rWaTo8Wx1mZSNR2A8k5Qke98BhnROqsYNRe8=;
 b=SNhEvVxytYFz53+qFb//LCADhb3FaZUcpH9XabLOBwzQyBvqWUcgbULVcZFCOz0HRYHKh33KeS8yYjzUB73T6hjMwbcPreH9E7kSnX6hHaBTsx/Tfx8WI36HB+HPsEkMbjKZh1kQmedzDbxWBHdfciVk76hJ6umcr1GC6FJynYk0dC5NX80Vl00CI0QxuIbiCG3q9p63Rh9BCt5Ug5eqRnxP9xc/VXJoXjpbzTxktRyfakQ5jy6PnSOdMToeJ6GhBkfYP8p+3G1zAfOBgDHYUieMYxnIm2b4LjG4djAr5GK0YFFq2t0E1Brl6jm1mhZSMY1nXBT4rbFpvV+WFdNHcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LDIby2rWaTo8Wx1mZSNR2A8k5Qke98BhnROqsYNRe8=;
 b=OJRek7Tv7FsgF3jo2H49k78VR2w0koZGVA5uNCGSMxtSUMBukSqAj3A8XjVmxpKl+fHK3gBHx0KGs6GpCUxV0xwAxjA34CeSybRB/Mb/qfk+uCeidKIwfyqpDJuYn6VqgHEcQqROOZetpFbbqSa/b8xy177aMfSkFxgcamypmE4GOrOBMmXJXuUiBv78iCgbFedlZ/35lkj/9za9UR+3liKqt9uQZ2Yh4cQ8/MDkSIEQPSUroYTWg4Z20Icpot7TuZyNvy1skkVYrK1T2W+3KXhFAgXrDpv0jlqRCUfXNepm+t9pfv7wZBZ5j0m0EJ8w3+1nvvS2Db02+5erS3Gy7A==
Received: from MN6PR12MB8568.namprd12.prod.outlook.com (2603:10b6:208:471::19)
 by CH8PR12MB9742.namprd12.prod.outlook.com (2603:10b6:610:27a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 02:18:56 +0000
Received: from MN6PR12MB8568.namprd12.prod.outlook.com
 ([fe80::f13:fa29:e7b3:4d3a]) by MN6PR12MB8568.namprd12.prod.outlook.com
 ([fe80::f13:fa29:e7b3:4d3a%5]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 02:18:56 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>
CC: "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "dakr@kernel.org" <dakr@kernel.org>
Subject: Re: [PATCH 3/6] nouveau/gsp: add logging entries for r570
Thread-Topic: [PATCH 3/6] nouveau/gsp: add logging entries for r570
Thread-Index: AQHdHxEoWZ7rcRcrdUC3RHOi0UsMg7aFVWkA
Date: Thu, 30 Jul 2026 02:18:56 +0000
Message-ID: <06fe1ba027b69a8687f421e3d4864aff5358b5ac.camel@nvidia.com>
References: <20260729041653.3985549-1-airlied@gmail.com>
 <20260729041653.3985549-4-airlied@gmail.com>
In-Reply-To: <20260729041653.3985549-4-airlied@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-9 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR12MB8568:EE_|CH8PR12MB9742:EE_
x-ms-office365-filtering-correlation-id: c3200880-29cd-4e48-fede-08deede0e8cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|376014|23010399003|366016|1800799024|38070700021|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: vCcRgW3A6GDy7JzV8yJUG6UcrZE1XfMIz2dzHMaieQBbp+yzapyDI9+lYTcDwb9QUqb/zWIzy8tnziDxhSrqnzN6l8EWnkUbtMgnIfC2Q/VU1zr6C873lNszKS3Nner7G/hUJMn6RbPgtsaLN9rmdKv5JbtExIQttm15aaWw4ZO1pR7c0t+wHeEZ8voOEHo1velLWhtNTX47ZLgNHskTkhtyTqrYkB3N7k4tT4d9MfTlUse2G2zQ+JM3Vw93PuPXEAWNgwQwcz3DNJ3dRIMXogJuqk7kfa5CbQ4F3Z3o7rpB/la3xaHOUHofZ6DyRnJ5J+8n+KzRXSqbZHCY1zPjMI9TdDRqupf0FUfp+Cky2nSEEKhy6nlJy8uIBC7RFOdt/Y7Td0DLCrxYmalw5QHmqDfslwU8dz0vFL5srb6qwO2r5Ok+TOirpwGfjZNKS8sLg857HY5mBiZMMMcEc+wNzioNEESkQos7rUyWVVxG2UbEyZjFIziSuXyM90/0doCN8M7D8avz8uw4nAIecnNv4JkQEle+7KPG+PHhsU7W9TuwgEI8+h26s5g2BHLnUKfg1KXwmUGq4b+ff5++bln+70nCRxtk7EczANk9WtvqQsHE1rP1D01/X/BjrbHiUg2ZnwFqP5yb+IvrEYX76VqoCpjZwttYmDakZl/2FMLiFQ5kJdJ6oDGcV0Ue1ygxNuFkEn8EzbHGSRXpYmIlXpShqQkC9i0EpG34AuJPNr9Z8DY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR12MB8568.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(23010399003)(366016)(1800799024)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnhKdUhlNTQ5VkM4T1RXS1h1bXRBVnBIdlhGRzJXMXZldkU5a2QvM1FWTzNF?=
 =?utf-8?B?SlZHNk1BaEMzZDhaRTF5U0dpYmtQbWNwd1puN1Ryb1VjMnlXeUdyRDFlZ3FL?=
 =?utf-8?B?N3EyRi9rTDVwUE43MjUzNFBRbHJuZ1YvS1IyMnk1UDhYblRzT0w0SGwzRkNF?=
 =?utf-8?B?QTRqSDBkalVaUmpLUEZ5QzFzV0xEalpkN0Z4eDZ2cWFFTmwwdGRab0JRQ3lY?=
 =?utf-8?B?TllIY0cwYVRNWHJsclRmTEQvTnlOWjlkQUg5Z2hYaS9Td3pYUWZuWDRTV0hT?=
 =?utf-8?B?WjVEdjFMajYyUVMrcGp6ZHJxZnA0SEdWa1JLNWdlbzFWLzE4MUMrYXRSWlUz?=
 =?utf-8?B?VkdwdDIyUklkbWREbXBHcUJkcy9CaXZKVGM0UVVhNDJvaUxwRThJTCs4VzZQ?=
 =?utf-8?B?c3JTMkpva0xnMGxEcG0ra0pZSng5bnAxTW9aWk4ybWk0YmoxR2VycVhXVGFy?=
 =?utf-8?B?OGduY1lHMkxXM09xOFBZR01OMCtUaURrQmI3RER1T2tyOTRXc1NWY1Yva2FO?=
 =?utf-8?B?WnF0U1FkRUdZVEZBYjZidmNCQStGTU9ia2s5ck44dkxCQUJhUU8yYW5jUkc2?=
 =?utf-8?B?QVFIOWFDUkUwOHFXV2dLN3lXTlZRRjhUR2ZlcHdJRGsxcHE3RVJISk8yblhl?=
 =?utf-8?B?ejdrcmtGN3A4L1l4aFZmY042d1hUUStPTUkwT3QreFcxSXZvZG01QWtBVngw?=
 =?utf-8?B?SGZZaFVjQXlMT1BxSlVrWHVuMWlqNklpTWV4WUhSZlhJcUhCV294K3lFd0pH?=
 =?utf-8?B?akwvNnQ0MTAvSTlWR0t3cFRIc2ZWczgxL0NEa0lMZjRlNk1RRU0xcndDdDhH?=
 =?utf-8?B?TFprcVh5ZXVBdUJrK3dmbHM0OHBRMGIzZS9qTTZyVG9lU0FEZ0htYlkyai84?=
 =?utf-8?B?c1BITGUzNUZwekYwWkxvc2cvN2N1M1hKTlh0amFvdmgzdWg1cmkrSWtvRXBV?=
 =?utf-8?B?Q1N6QkR6Zm5vb2xBMkFXdThvdGJVUGdMOWgxR0FQcWtKdVB1YUhkZHdaZjBE?=
 =?utf-8?B?UkZtMnovZU1hcUNndE05VEVuVDVBRHllMWZYdFlKWC9UQnBKVXMvM0NmdW5X?=
 =?utf-8?B?eGJoU1ZoMjBSbFA1cllQMXhqVHBYQ3k3VG9tUnpoQ2kwbUFjQ2lSelhWWWk0?=
 =?utf-8?B?b0pFemNTQm1kSFpLb3BhOHZ2bFZ5Y3lMcWZHOEZINCtuRHlmckZKMDcvR2ZE?=
 =?utf-8?B?MCtuQUg5MkVjNnVzSHhmN0FWbC9oWmlSQTd5RlFtb2ZtTXNucmcwb29jOXFx?=
 =?utf-8?B?Q09ETllVKzJxK3VqYmV0NHVNczhSdHF0ajM1Tkl3VXRlRlkwWldiK0tqc3h2?=
 =?utf-8?B?TUlha01uRS8yU1Y1MEcyTTdIVmkzT2ZZdkxEbkdubmdsc2RWQ2M3YkxiMWdx?=
 =?utf-8?B?eHlkOWNrblFHUVRRMTNBM0MrM3lJeUpHZndtUmVKZzFDQUNKNzZJaE8zdnZB?=
 =?utf-8?B?TmFFKzdsWUVUaWpXbzdPNHlrN0w3TkhkQ01BMklSTnc4ZXdDc3AzeXVoMjk3?=
 =?utf-8?B?a3VxUElPanlUVmNueFVvRU9sbXpVanBnK3pPR3RnZnhmV2tCODBJckdqdkdF?=
 =?utf-8?B?aTA0bmhRVjExaCsvcytocnNBL28yM0ZsU0tuWjU4clNxR3dHOXRSdjZGZ1pw?=
 =?utf-8?B?aFAzR1EycExjQTdmcjdVUGRweFhlUWFaOWNJNmZlYzU3T2c1OFRhVXhkMHVC?=
 =?utf-8?B?VW1NR1hqcGprekZUb0MwSTgwejZKcDkrWWRQZGtOQWZQeEJPNEhYY2xzMnk4?=
 =?utf-8?B?dytBRkxOQXZWTzRGVEw4UkIrN3BGcTFRN2dHYVFFS0lGQnJrYzRyRTFQWkkr?=
 =?utf-8?B?U05HUkFVMC9zc2dmUFhIVUFYam8rRHN3aS9TZDE1US8vNDYrc01LbjZnYzFh?=
 =?utf-8?B?T01MRUVjdXJVREpRN0s4NzBhbEkxUUN5WEZESVN3Z3JDMzdJaVlqVjk0NjRH?=
 =?utf-8?B?U29CQUdGbUhOaDRROElTanZzVExVWFNYMXNDWjhycE5pd3EwUTZ2MW41bzVp?=
 =?utf-8?B?M3M5QlpXRy9OYk15c081ZXBzOUlkTStzdXJDSGR2VVdxdEZtY1FiRDFsenVo?=
 =?utf-8?B?RDltd2RCb1N3amFGT0d3MnFhTWhhd2lkOXFUeGo2d0d0bHVNck84Slc1RW9r?=
 =?utf-8?B?SDhKUjhVM1FSbllvSVF0bmJ3VjlncUxIemdTTEl6aTV6Slp4NjAvV2RCMWdC?=
 =?utf-8?B?bi91WTQ2TnVBNVhzbSs5VFYrYm1UMmxYWEIxS3RGN1FaUnF5cVE4ZEJPb3FX?=
 =?utf-8?B?d0lwQ1lXdmdySXRianVGckd2VXJSeVZCUmJxSnh4UkdIUUgwSStkUzFJUk41?=
 =?utf-8?B?Q1JoZndBOFhBditDOVNYakx1THZRUkFnTStwVDFuRnM1V1N2azN0a1BQRG5q?=
 =?utf-8?Q?Zxc3/7hxCJ0CTmJj/4VZ+ojgwU05ct9ZDy8CzJdm4BFij?=
x-ms-exchange-antispam-messagedata-1: wTiAzgUgxy51Yg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <A43754ACFB5C6D409FC9F4203554058B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR12MB8568.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3200880-29cd-4e48-fede-08deede0e8cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 02:18:56.7323 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R5QU8cGCS2NNLR1oDfNyWTdeXHTzKmF7DAzHnglfmZ4CgQQSfSp9DqImWW1D2UtY1NUUjwAF0xu7sUPo2ahuRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9742
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

T24gV2VkLCAyMDI2LTA3LTI5IGF0IDE0OjE1ICsxMDAwLCBEYXZlIEFpcmxpZSB3cm90ZToNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL25vdXZlYXUvbnZrbS9zdWJkZXYvZ3NwL3JtL3I1NzAvcm0u
Yw0KPiBAQCAtMTEsNiArMTEsNyBAQCByNTcwX3dwcl9saWJvczIgPSB7DQo+IMKgCS5vc19jYXJ2
ZW91dF9zaXplID0gR1NQX0ZXX0hFQVBfUEFSQU1fT1NfU0laRV9MSUJPUzIsDQo+IMKgCS5iYXNl
X3NpemUgPSBHU1BfRldfSEVBUF9QQVJBTV9CQVNFX1JNX1NJWkVfVFUxMFgsDQo+IMKgCS5oZWFw
X3NpemVfbWluID0gR1NQX0ZXX0hFQVBfU0laRV9PVkVSUklERV9MSUJPUzJfTUlOX01CLA0KPiAr
CS5pc19saWJvczIgPSB0cnVlLA0KPiDCoH07DQoNCk9ubHkgdHUxMDIvZ3NwL2dzcC14eHguYmlu
IGlzIGxpYm9zMi4gIGdhMTAyL2dzcC9nc3AteHh4LmJpbiBpcyBsaWJvczMuDQo=
