Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CD5606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ez5kgw3h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CDCA10E7C3;
	Wed, 25 Nov 2026 08:15:43 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F74110E159
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 08:15:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DiuGSoFhwE1gvQme9urKyZtqGogOY2xU4pwVStfUjXNx7IqjxlHJwtZiQ+IWGIfcfKn1WY1E2mTXGdHlrC7mOuZNwZE4/8GMjqOM25i2eku0PDcYyVlF20HLxGdf3ZPtpXeAa0PM8GF4cZUCWO3dvdmiCq0t4/m+VKF6SsLYAonTYCNx8gpaFwu4b/hElPAzf6t2FK5JLKOC8dVoUqKnwH/pA8FkXNbye0XULf6y9n7d4r48wodqZWKblPY6H169rn1h/x5Z5UfEtsK59OF97uT6bfsMMask+klWVBkQvcjDxkv+mwNpGFzB2XA76wuC3XJxJ0jsNTeY7GhgjedYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hl1fcWuGOTw5bldQRqgAImMVWeWkgrDm5Qh7FC/A4PM=;
 b=w/ZlUNuZ9ikLF6RrT0ga8DwYLSEuS4cUImQC0a3QZCdrdxxF4cFrrviWOHWTK19kCkmo+3xeDy2aLS0eAt9XcpiDVQXbXmYZBa1beA11ferjOAY7sF+hkjAHiz6wn7CHhWiJwLuh0nVVfaZ1pcLgashU8UneE0Yp4pol2xqPaEBSSP9jgTEmufbP/Ks0hx8kfIoYGIr7z03tjObYPxdwBI1jhgKtpBz2DGLVjgjvfuj8ODBRmbv4BZ9aZmhJ90gQnQgfCF9j2gE4YO8R4J5wuo57SWNU7Jq8OwL8Vx8owG+y817Nd3QyIYNsVhEPLy4KF3M7ipT+wOsp+FosOMZSxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hl1fcWuGOTw5bldQRqgAImMVWeWkgrDm5Qh7FC/A4PM=;
 b=ez5kgw3hbJR1HjHqI9PCKnK/k+TuqhEBIxuIfPql7ocVsxATKwvOq9kDcAO5MuqSsZ9Wp5N727c40QyN+F47+FVQY82A+kdyFPz8m3kZwqhm3Xyja7mEOiqgED62jPIpcrqN/0n0Pg4p6WBSdHelUf7e1b76T39Wv5L5goDSSjcIB1XlVa5+rs1u1R/ChfA+bJwa489kNm94hXuX9amd1/IGO8ytHhPrTmNJku+Nph7pLtFFx2AwVgHQWYkslbWj5Tnztnhxvu55tNPm0fmeslgvhgccFpE4RTKMZg4rsc3GodJhm88ig9vgxZuQQVJbqtLXYB1d7kWtzOQX1N8N7w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS2PR12MB767817.namprd12.prod.outlook.com (2603:10b6:8:3c2::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Wed, 25 Nov
 2026 08:15:34 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0662.001; Wed, 25 Nov 2026
 08:15:34 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 17:15:30 +0900
Message-Id: <DN454ZNZ4E2C.1VQLLJ6KTK6JP@nvidia.com>
Subject: Re: [PATCH v2] gpu: nova-core: use Init for firmware initialization
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20261122171353.963020-1-dakr@kernel.org>
In-Reply-To: <20261122171353.963020-1-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0327.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::20) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS2PR12MB767817:EE_
X-MS-Office365-Filtering-Correlation-Id: d3032c5a-f6da-46b5-a428-08df4acc4723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10070799003|18002099003|22082099003|6133799003|261021121427099003|261102123227099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: A9FMqgCHCQQpY0fm9ltSK3enHgCKbXKpH/RRFEgteP6CYSoNe3nFlY4REPx1z/7zQVkavKfCdlK+eKU0jyhLRdG8nlTV1LE6WQHtUgWz09wRYNSp/oPLuXrRrnyeayIJyA2lcfMdzuPRZmEMW9Mw/pX0ZMG/zJL6LER/tEIgTvMFd6TxAXIdiFhSXWPN1av+szihdm+3IWVGRgOAdAPw+E2xfBqyCa89P0KbRYmYHBnk6qm0yv2tvN6S9tFF0pFd0lEZwdXf6G4ZpTwmxhbX2bT9b8nFD4N/zE5smJM22xflgOF/T3UUPSBgZKeDZ7YWzYFJdt3tSlCQ/pLAHaB7EAfvXQfK3eLJraPLXPfdLhVzlmYPHUY0mW1eJH3PXinRrnu6zK8YooIWh1CWd0exspuTt1BRUhUM16zu7hV+6bHWzG9zp6+OKLJKQI0idW1NKBBC9R70QSgoQqOhvDh/U0ybEM/EvkukE+t2CmNztsPlVyZ6bO0K2A1a5gb6CwSxCgaX0gj9U91u7LgflIKWEQHH9GKepLY9PbUX+MAXQw67HacV63Ul7qfjh181eheFXlsR0TfToaDEYR42M0XIDpaYGgSN3UgStuS5ehEqbnsH98usDeH1Wf405G8TGqqT1/OUoKXN7faCdZVX7/1LQOCQqbyNkt4XHosStt/CC/4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10070799003)(18002099003)(22082099003)(6133799003)(261021121427099003)(261102123227099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlZadlpYdnRPUEJnRFc0QXpnTHJ4VUo1SWYxZkJtT2p0WGFNSEpTZVFrVEJH?=
 =?utf-8?B?d2Y0emhlOGtXaWpiZEhwMjhOaFptQ3kwajFxRFlOZW5hTDQyekZFeEZZc01I?=
 =?utf-8?B?SnJCTCtIVnJmWHJxR1B5L1JPUUZGZDVwLzY3SzlLQlpxcmVTWDJyV2VqcVBJ?=
 =?utf-8?B?dlJVeUlYTGp6V29Kak9zQmRSYmZaelQ4SkszTXpHZm5pbWNJaGdJWEMwNVYz?=
 =?utf-8?B?bzlHNFd2MEJyVCtSYTcvN3JacGFmR3BXcyt6ZzhvZDBDT2o1d08zcTZncWVj?=
 =?utf-8?B?V3M1TWt6NnB1UVl1S0NpTWIvTEJBNWlMREc1K0FQK2RCS1JJdE5uRHFpVHN5?=
 =?utf-8?B?WXpIWkJEZlI3QUVPcVA4bUwvOXM5SVFYVVd0Y1pHSGQ3amt6VHlrbWFWTSta?=
 =?utf-8?B?UUhMcnNYZUVLWnVYM2NNVzdmbC8xcGFPZDFlRWozekg3eUx2emtXVjdQa29O?=
 =?utf-8?B?K3pTY0g1OFp5dmdlT1E0S0ZIL2Mxc3ZVUGhSclBLTE10bGN2TDJ1U0NQa2xN?=
 =?utf-8?B?L3M1b1FSLy9WcTBLRHR1U1FOSnJlbUozZDJORG8wU09QZkI1eUovdjNlSk4w?=
 =?utf-8?B?dWtwbW9xTFdZbndTbWJPUGhoa3pEU2ozem05TXJVTWdVekdqSnp4UDdXR1Bq?=
 =?utf-8?B?UmVYV0JyWDBvN25qSWFuVlJXa2JrRDlnNVZ2RURuYzg5YUtHZkUyVlZZTncy?=
 =?utf-8?B?NTR6NytVeld6UGRMTFRwamJIQS9Hbng4QTI1ekFtRVE1RTJ3aDIrclZDa2Fp?=
 =?utf-8?B?MTBqRDhDdUhheXVhbmVuYUR5cVYxV2k4aGg5a2t1eEFDNG1VdlFSSmFQVi96?=
 =?utf-8?B?TkhINStaS2J0L0RJdldRU2gxK0lCVWF3V2xMVUtYY0pQY3hmbXhOVnZSZlBn?=
 =?utf-8?B?TjBaWmhXYzJSOHJ4TDBYNC9rTG9NMWJkOFN0bnluT2dwbUNadXk4YU1xWnB0?=
 =?utf-8?B?WnlaQVZ4anU0cUgybm5odHBpUXBxYVlhWGhjb2hGV2FJTFVBNmRVdC9WV0Qr?=
 =?utf-8?B?dTZaMDJTSFRMaEVnTVlpWU8xeThNR2pCZ0t6Q1V6dWFnVjFFQmRVVGJicEFT?=
 =?utf-8?B?Q2xrazYwVU50bmxaZHgxVy9ZWW85U2pXcUQ2N0pncm5ObmVjRERNcXQ5UkRS?=
 =?utf-8?B?UnVDQ1ExV0FjTlJqVFpGUitTSE16L3AzNlhJSlZMdXRPT1JESUNqclVBbm1C?=
 =?utf-8?B?VjM4RXJ2My9OUm1mQnB4OGl5b1licFl4Ynp5N01lTy9TYVJHMFZFV0JvUVZn?=
 =?utf-8?B?MTVmbks5dFZnbm9jK1Axcm92NDNmMVFSeFZBRjltVXNXQnRMbnRhSG45Vmw0?=
 =?utf-8?B?UGxkOXdaNzFLUlljOFR3RHRUVzVob05RTk9OSXhzalFwUFhzaGs0MGdYL1NX?=
 =?utf-8?B?Vy9pTSs4cm9qcHlSMHhRQ3dlckEvODE1QkdjbUxnUUtNM3o4V3hrb0xvL251?=
 =?utf-8?B?RXdsaGJsYTkzT2d6WERxbGMxSmF5MFlaVEVzTkJwZTlFNUZ6U1krZ0xtUGg2?=
 =?utf-8?B?VmM1dXlhM1p1dUNpWGFCdmhsQWdRUFdlVGowbFU5TE5TRWFqRTNQTVdSb1lG?=
 =?utf-8?B?dXR0Nng0M1c1dTdYTDFlRHhHL1RTZ25LOGxtc2xzZFdCMGttTTJNT0ZLcEV6?=
 =?utf-8?B?R2pETnFRUGZUOUsvazBoejFBV0czSWNoUzRlQ3dCRGtWdEt5YWpVOWNWQ05O?=
 =?utf-8?B?TW1WWkVaenJ5NGZvbk1wTmVTNldwYnJUd3B4MWljWUttWFZWalNXYWZmdTdw?=
 =?utf-8?B?eWhNSE5ENWxUcG9ZMFBBYjZhNXQ3NUZTWVgycFBOVlNyV2hHOWM2cWtaMjFk?=
 =?utf-8?B?VEF3c0V2RlFxaVJNZnMyMVhZVnNBc3VXbGkzdmdQNkliZlBDTFhucWZOY0pw?=
 =?utf-8?B?S3BWOUFjYzBGSVVHZ0ZmcnpBN0M0VTVxd1Y1M2VYK0hXZVQ1dW42aHROam1R?=
 =?utf-8?B?RnM2VFhXRGFlOHYwdXJhZk1JWUJxQnVqQWEvYXI5S2JhTHpZSnJFYTBZSnVi?=
 =?utf-8?B?NzBrMzkwcXp0TmEraVpkeTZQT0U3ZENwb2pYbWlwWTZjSm9EbVplL2s0NEpI?=
 =?utf-8?B?d3lTeVVDZG5UR2kvVTc3SkVzSTBERTVqNHNaYUF1ZkpWNDhGWVAzbDJUMDJN?=
 =?utf-8?B?bWxLR2o3Vk5pSlI0WGt3U2hsWDU1ckI2ZXdCU1phRHN4M3FCbHQwSStWd040?=
 =?utf-8?B?VTN2V1hCT29ndUUwNEt5a2ZrMUdUN1h3OXB0cWlvQTJGTXR0bmo1dm5YcmJF?=
 =?utf-8?B?Q05PNkN0eUxhT1g1eEJ5bVhIU1AvOElaQjZPVU9xUDhUUy9kR0hSWkxwWEtD?=
 =?utf-8?B?Uit3NUp5QWl1MUVCcjRQVUl6dEI4U1hpdVA1aUd1U0kxL3lYb2doc0RoUjho?=
 =?utf-8?Q?IJAMhCOQDR+D/kFZnIROQCb3I8qmqCYGtXDMC/MnVtH7a?=
X-MS-Exchange-AntiSpam-MessageData-1: +hu9Ul1iwgCbWg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3032c5a-f6da-46b5-a428-08df4acc4723
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 08:15:33.9268 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yC7lnVW+qBjDxnPqZrSnHrB/moncqP0UKSF75DXrx2/2H3ke4SF06Ts7XjjEDOc6sJhdhM8xXUUB3UW32eBnlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB767817
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

On Mon Nov 23, 2026 at 2:13 AM JST, Danilo Krummrich wrote:
> Now that SGTable no longer requires pinning, move Radix3 and GspFirmware
> from PinInit to Init.
>
> In an x86-64 build, GspFirmware is 312 bytes, including its 216-byte
> Radix3. This is reasonable for the stack, but returning it by value
> increases boot()'s local stack reservation from 432 to 1040 bytes.
>
> On TU102 for instance, the nested hal.boot() call reserves another 1128
> bytes for locals.
>
> Thus, keep the KBox allocation and in-place initialization.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
