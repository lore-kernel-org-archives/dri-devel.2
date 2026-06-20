Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FC6CD4F26
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 10:48:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 709B110E164;
	Sat, 20 Jun 2026 10:48:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="cBrD2vID";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB82210E164
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 10:48:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fu1AD07j4EIC0jV/vNIW+inGmNoSF+c15cIkuVnmpp2ywNUo05adCH5DokE+hSILTBPPs0Za4JunH7SMF/zw9nAd2gK5voYXUMf/fb4Dssc86jSilE+8NX9NGy/4lUZxecbg79pzqvJ+pLVrVqT2wsxpBI0SSTVE6+lclMifYPOQR7BJntB4Gh9WY8jsu6nkfzWISWenJbb1rhJ/+Yk364h5aYxcTu25pNRLwl9eMtz1Pq0wLOtuR3+iOCHZ4xBBV1Ui0lbCNOmdKSM1QWgYEulFlRZngokd236qZEsx84LKuU/M5zzx4e2fYbJz790NhaCE3qomgEYUk+n0QCuMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65qqXEXgqsD6IavO6LxCnlSco0gD2LgyKy9qJJwV8Yg=;
 b=nbH45CXBWUJmt4xxtQxso7gOmejFL802urjHRt1rnT/Cnu9dLZWS3pnfRgHKld8pF9ce2wy1Qsue12tsllBwpM7uXyav3IDZUmRbxFmIKsqWFdHlN4tNe1fIRGNUicRmBZiUA8DwRbjTWy7IvJAYRVvvXTpuixbUEH1BlXWacoc6x29y2Lt+FfnExKSaY4BuKYcMUQsvnP3QXI5XVTh8TIL/mlyFpHiebzEvuQOfbaaGbJTmSQomX3NoGUJH1MRrjYyw2SGoKYJa+zMmM31nvVuSgX2om62FFOcrABWG29fTxSryAmb6bRwGHsZP3oqpUUY+u30FoVnHjR+hFtLdjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65qqXEXgqsD6IavO6LxCnlSco0gD2LgyKy9qJJwV8Yg=;
 b=cBrD2vIDPRKA121vTavhdYfJmqUq+2vTbvUAtAXY5Wj+2tnQYOImSBNh7HFOtrKKzb42zV4EYfWq7/bKMFFxslJTnWhO01GkM2AUq9FhWhscFNCCjT177EJ44EiElzBdAKs/0GkEJOg3rzGPrtR9Z3Y92iQcGjBeAUXkGAEGcfaYPdnuZ8yNuXo2vsxVfCS7IRxHoVfG3zK4EJpFu6FT3mC4vUx0U6pYN8X69i6810Td+0GBrase0l0+Ci2cqyKib5SvZxdWUGqQF+iCdy2ZyUqfnLL7V9Y8L+OSFvTIB2ePI0XgyD5SeH1lubdY4G4fGb925CHy3m+fCCrVD8ZOpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SN7PR12MB7809.namprd12.prod.outlook.com (2603:10b6:806:34e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sat, 20 Jun
 2026 10:48:05 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 10:48:05 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 20 Jun 2026 19:48:01 +0900
Message-Id: <DJDTFOOD6BDC.2MOEQNMG8K4CY@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 04/13] gpu: nova-core: falcon: gsp: move PRIV target
 mask constants
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
 <20260615-blackwell-fixes-v1-4-f2853e49ff7d@nvidia.com>
In-Reply-To: <20260615-blackwell-fixes-v1-4-f2853e49ff7d@nvidia.com>
X-ClientProxiedBy: TYCP286CA0273.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SN7PR12MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: 209846cc-da43-432c-f656-08deceb9682a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|1800799024|376014|7416014|366016|4143699003|18002099003|11063799006|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: KHKS7kgzRAUxpr59R90LpxxfYDMPjacOB6Vj/84fnZgKv8Gri0UpccvfH4pLWfIhXChYvU2IlM9yK5Kt5lv62c+Ec2wpwDpARV1Z9PtYcXMfPhrnAK9S+wwBUkFTpCy8CJ05yF7WpfYHjpT8cRNLrQnyYp/Hp2QrIcUNbQj5NjWUMyT/3k34cHMeeDwYmspTUvqylzLPwtfbVZHVEFG4lQax802r5gH4QH9UZkGQa+B1hIY9y1+8c/Fe/61qIF8JFiBOzE2o1Z2BX1RDpSq5y/t7hNwI/z9kTgBfPo7Fy436PnS7DPK7CnGfmOfbspXKDu6L3cJ1iWJMVouqSsjoSjxua/tWEoJmjwHQLh4t1BOm7jl8tDBSBmVJN6y4o1v/OubHdI762tXOnw9qs8j7x8S8PwX+LDWPoYLhsSjLd8lTYFO/mWghgfj865kO5byP3GWQoS8nO6PVYRY+1COXVARm5NQyHoHXcwpX7hDfM+ZAM1n1oay2SnNqm7kQS5c57FyXDz57ymhsndRX37jORz0hzuNyGOzIt5/0sSSuP167brJrvswe34M0rjX8e+ZRYJgejBAm4VZnSc1hpCXnz7cIlQNFXslf1WOZ+8BEBo92ou1tYIL2aSerLlEcE0qZObD3VCPRCr4O48k2Z5xEslkcgaU33lACxAdWQOA/Brk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(1800799024)(376014)(7416014)(366016)(4143699003)(18002099003)(11063799006)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWJ3NUtGRWU4UGpzQmZ4anNZZlV3YVhSSURyZkdtY1NaR2I5cjJGT2hBVGp6?=
 =?utf-8?B?RE84eGNvVjk5bnlqc0NMQldFZzNiY1M2NFpQQklOa3dxcDROR1V6R1oySkNP?=
 =?utf-8?B?RmRoMW1mRm5ONHo4Y05SenBUbysraWhleTNDWTd5VjRaWG42R1ZRTHN1SHha?=
 =?utf-8?B?a2lkZk9wMXpzMDZrM1BQYXFTUEJKQk82Sm00TVRHdlE3cmlJdWN2Zk9Gb2xl?=
 =?utf-8?B?NXBHcytaZjZEVjcxeDF5NFVJeTMxaUZSd08rdWFBbzF5Q2EzaW11bTZXZXNR?=
 =?utf-8?B?Z2ZqQUZqcVlMRVpnSVFwRHl3ZlZ3NHZGQ1dTTFNYU3YvVzNEMTd1YW9jSnRh?=
 =?utf-8?B?cTc1cFp5aWFwdzEzMW0rL0ZZQTA5VVorUFJ6YlUvZktaNHJRMzhkdGlGTXpu?=
 =?utf-8?B?RmFCd21PR04wOXNUVnFlMGl1aW4zVVFFS1BDMWJGdFBXajVlbitwQWp5aU9o?=
 =?utf-8?B?MTJ4QkFPZHQ2NS9UeVRWZlN0TllLTVl6Z3hDU2tweWpzUkJ6WTN4VFFsNFJI?=
 =?utf-8?B?SzRGU3FqOTFZZWFGeTNyd28xL0xKd3NxaVZZc05xOXE1VnNJM0RCajJHWE9N?=
 =?utf-8?B?WGxHNGdmOUpOeHFiWk5va3hVWXZJL3pHQS9qOTZhZVYxZWVQTlRZaFdsQ3FW?=
 =?utf-8?B?Yys0alZNaHlkTUFkYklLMUZ3aUF6VmI2ZlF1WHpLTXZXMmVyU1dLZXF5YWV1?=
 =?utf-8?B?ZnRBeitLZDRJWjMvZWhXK0RTajlhTTlwL3ZqRGZ0dFBidDBrUC9RT2tYeTNU?=
 =?utf-8?B?VUZlangwajd3d1QrcmtYdlNiUmhQcjRORnFUSmEvQm1DeW9hZjlUOFRyQmMr?=
 =?utf-8?B?OWZlYkxmdWZMR2ROYjZhOUJRSkR5K2tBQnRqRlRTY1FUVkVJTE5BYjBTU2Zh?=
 =?utf-8?B?anFEbFdkS1p5bStYd3VxTXJ3bmFFa2JlVFZUK3IyZjlOR2xYZExUUXZQeG8x?=
 =?utf-8?B?S0JwR1NSZFV1OS80UTQwR3F0UVpTOHN1T0w2bzM3VXdFRHQ4NFZsc0JNYStt?=
 =?utf-8?B?ZlAxZVUyd0tOWGF6eEw5WEMzZXFiRWpYRTcrY3Mxc0I1eDhtMmlJbnhJY2g1?=
 =?utf-8?B?ZDFrelg1QVFtUWYyaDYyZUVGelBsZjZ4TTVQM1V1YVJQVDhrLy91NWp3UXlS?=
 =?utf-8?B?SFJ0R1Z5RTk5RjVocVl0dElBS0ZyRjh3VVJWQ1RoVmhBaW9qNms2cDBMT2wz?=
 =?utf-8?B?MVJrbWdyT2RKbDBCeHZnSDNFQThTTWgrWnZ1b0xjVXN3a0Y2QTRaaEpkMVd0?=
 =?utf-8?B?T3B2YVVmOEoyVmowWXJDMzZCK1VGdmpZYktUK1J3Q2NqcDRFZHZHc09sdnBl?=
 =?utf-8?B?T21pVUt1bk5TT1pvVFNXUXNwcHNIR05uSE9rOUtVY0lqRFA3aFRxVWtRSW5K?=
 =?utf-8?B?ejkyL08wMXhZSjBsMjFLS0VZZ002QSt6Zm56NjUvNzQxUTE5cG9YS04xeWZF?=
 =?utf-8?B?S2lCbHBLd1lLRFdrWVZBMW5qcTRBWWo5ZzIzWUFXYm9oMFdPTlZta2ljdnVO?=
 =?utf-8?B?Q2xwM0tEbHFwTWxxUDByT01vc0ZkQXdsY2h4LzdJVE96V1Z1dTdwbGJnS083?=
 =?utf-8?B?NGJJQ1ZDcXMyWXYvUW9oTlJhWjRQa0J1OW1rVWRQbXkzWHR6Ull6YlRwLzBx?=
 =?utf-8?B?SmZ6Qzc5MGRoWERCZi96NXdldjNBa1BxS2pUVlVxc04zYnhqcEgxSU50L1Vz?=
 =?utf-8?B?V3pSYXRBOUh4QS9KcjAxOVQzdHpjdWc0OU5rMjlOTGdHeS9FUzBwbENsTDJw?=
 =?utf-8?B?U29tMlFUSUdNVlRaMFlDcG5sL2N6WE5wc1cvUytqbFMvSlgzZ0Nja2Q4MEVI?=
 =?utf-8?B?OTc4Zm9ZOXUyVzNDNXBaVC9DTzhYZExnOGIySktsUnJjVWVvdlZDMzFlQVIr?=
 =?utf-8?B?NWx0MTFVd3JPeitERkFGREo5T3hBTUN2dXdZNkxuMVlObG9lNmdmb3VCZkZV?=
 =?utf-8?B?TE5oWmZPeXZLczg1ZVllSWFRcVBTL2hmSE11ekowbHo2QmVRenhDaURjeWo3?=
 =?utf-8?B?NDN5aldCZWZoLzErTzM1YlEyNWVQR1RoK1lYS3dNbTRpYlFTK05BYU1XQkFa?=
 =?utf-8?B?SDc4L1IzakhBZnh1bUR5aE4rUGluWXNZS01VOHZvcUhPUDVBdmFGSEMwWS84?=
 =?utf-8?B?a1NEN2hRbGJuYTR6Y3Q3aWp0OTRMOEYvVGhtL25hTTNKdVVzcGYxMFBBaUlh?=
 =?utf-8?B?d0prbThaeUk0azh4d0VlWjZObDh0cjlJODY5YTVrUnlxR0lzd2RYaXVUdWN4?=
 =?utf-8?B?elg5am5zR2trQVNpNk9EOU9mYy81Slo5SEdQb21nWklraUR5SDlZM013LytL?=
 =?utf-8?B?WlcrRkNrcXp0Qng2bzhlV2dSYy93YU42MG1pU0lvT3FOazV0d2RyWGtxOVgw?=
 =?utf-8?Q?Wi9V4zZwCPIP0R/tw82UXgQyrr65qliRBodILhgqt0ku0?=
X-MS-Exchange-AntiSpam-MessageData-1: 9H+JuO/fZK/Uew==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209846cc-da43-432c-f656-08deceb9682a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 10:48:04.8462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0CjviiUjVXNfpaAMNsOTHElWn1+UnM28JELkigkeV/JU6QHllY/eU4j3hMcMbmgDh/zdpigO4g9Kp13rU9p0uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7809
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

On Mon Jun 15, 2026 at 11:40 PM JST, Eliot Courtney wrote:
> Small cleanup to move these constants which are only used once closer to
> their use location.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Pushed to drm-rust-next, thanks!
