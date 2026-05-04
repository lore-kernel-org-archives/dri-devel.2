Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9313FF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 19:50:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDCC310E82C;
	Mon,  4 May 2026 19:50:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gedp58Zr";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010013.outbound.protection.outlook.com [52.101.46.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A5A010E82C
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 19:50:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h78NMJQ8E4wnPVnRUMx0m98LDjqyY3mTNN/DIG6z0ufevGAuUjbz/vzTBF39SJyC7M3aM/8O8ENnTcz6OwWLe7cGczVV/Qd7Ny0lHbl1HCjezvcCrOvRWsUpnyFBdUbRivqNMgYbOaQdtkvSyExD2n4FUCni+iMJrGuPleQfEhJmtFSYmcTT48yj1Lj721zzK6DRKXzOZNsyEDt6AbdcC0/UKCZ0+TGPr+TW+VsCx+0bmwAd4SR5gvdrwbtgb0rIrd39m1qrfdWemgxd7hO+DnYYLjhP6FqqLUErkZMUZrt0QDijl4IBFRG2UIFNh1Hi7yDmdd4gd7r7fIFGZovXqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqztR4XjflZrCuKmFMnD8srNX0Kc3+EpxefkuTMPdPw=;
 b=ag0bj4ZkoIkR116M3Q++Dsh4aTYgJez3xu/CJg7nOIJc2HmuybQuB0V9DsJXvi+ZoIsC8qSy1Zv29P3IuvT4EwmhqLIaw/niQ5OMGQIWaCC4y9xrfTIhsaQdrgHX1I6Ye7R01ltp7RuWBSR3fd194wOzDMMbPxaqeJDFua6Gh5stCYx86LFZmEwQoi/tx2B8Ih2Rj3ha9EeY3acvUckt6BIzZ9coFIX/eMSaGOG5shld/wwqX8JWyweS9luicPlI8w1I6C/O4kO0TJDxr+0MNx1+AOWDywIg7unyYCOHsH7mHpkxZVizTTxd3ptqCRswqmMtOqt5hON7ZvmcWpLtXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqztR4XjflZrCuKmFMnD8srNX0Kc3+EpxefkuTMPdPw=;
 b=Gedp58Zr2t5OlYGzbLzAU0js20GjnDGOfUV84ZGvSq+dy/y1qk5+yCHfJsHh2TosvOU3bgAjyKxb4YL7ydqrYBdnUOI1XWOA8jppEOYXRw2QNcoGzwXKX+FyuReOTclI1UuB0kJZpVp1v6Q9ShgoyPWBi+Fp9kYw8A5oBMIh8WirYXiE+ja4I5lQu0+a8rv6qjS1AOdLDgeZ0yetBk4mr+MRwfCGkAyeWQcEz8RMOJwBmc1Zyyq/Z5ivZqmYwO3kKBJWqRHDk+m+JDMZ1aWY2w6bp7Yw/kh0+7RPtCT9E4a5PDpqQn3NrW6ypf7XWaKAXZLmPWz9dZ0oWntpZDYhiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 MW6PR12MB9000.namprd12.prod.outlook.com (2603:10b6:303:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 19:50:51 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 19:50:51 +0000
Message-ID: <be30c1e1-414c-49d9-ba0c-4be4f486e8df@nvidia.com>
Date: Mon, 4 May 2026 15:50:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 12/22] gpu: nova-core: mm: Add page table entry
 operation traits
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, linux-kernel@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev, Nikola Djukic <ndjukic@nvidia.com>,
 David Airlie <airlied@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>,
 Andrea Righi <arighi@nvidia.com>, Andy Ritger <aritger@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Balbir Singh <balbirs@nvidia.com>,
 Philipp Stanner <phasta@kernel.org>, alexeyi@nvidia.com,
 Eliot Courtney <ecourtney@nvidia.com>, joel@joelfernandes.org,
 linux-doc@vger.kernel.org
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
 <20260425211454.174696-13-joelagnelf@nvidia.com>
 <DI8B0IOXNP2L.1NFX4OTABNHA0@nvidia.com>
 <53c88538-dca7-41f1-bb2b-856035728c69@nvidia.com>
 <DI9YR10HH6PE.AMLEZUV7701V@nvidia.com>
 <bd210abc-590f-4011-8337-21b54780fd4c@nvidia.com>
 <DIA5D0RYRE24.2LB65BF0UK4UI@kernel.org>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <DIA5D0RYRE24.2LB65BF0UK4UI@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:208:52f::13) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|MW6PR12MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c1771fa-08fc-4dc6-f0c5-08deaa1671c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: mGtEXwgeRbRCg6ggWPIh2TTGy1xA31nORnk/95INctAe072NAEwCYzODHE5ZufPr7AOOV5zf2h00oRvwpr2kA5HaCub10wBYYwyz1kp/zvgi/XwBJeryjxpE+OpakVFaMI6JfrUlkVmD3xpYFOK2ot5gETaaYthTPCf2uOHWpCEmURoqTmc5Q5GRtrd3Y675dQpluQLG6t1uxeq3odhkD0tExQJF5g57SY7zGf+3sXkvxuTW1Yw+Gn9k2CSp1oxrDglk3AMtzLW9ID706KZDihoH+xCZf44rn6X3N7vTpItkbSGIdHbknNU668/rbruWiaQPS3Jvfs8Fqd74n50hI0BxxvUk19okKak0NSJSIz5YkCUsKzhPSApKBeUsut9xO0qJ8QgK2DHs34FqmqnmVdOeiRHPOpFZV5evntg31l7WhL418HvvrUJ1PY20EBHrChJbPWYrSS0KZBtGoUPbuohu4YLdgiyM4Hz/sCrReaIIVlbuB5EJ006aUAURp75RtgxJAYAnL2+TMYipQjLa2zYRT7hufTu1iPL4jJcW0XQOT7gGBLojcCggPycQtjmlLQXHERab/uqS12RyGraWSh4NWxJMOlgKQgxVpWTqsvMRpuGWmHJHjl9Je2oK7XrrD0bmOQA3hFftBMdB8zTBPwn/t9kgQUJx1T8+M7CloZZS5UUls4VN3rIxGXIht6tK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXpJZGNoSDRDSFFEenZBeWszbVhkRi9XWWhIcTI2MElKblVOQnd1NjR6bVdW?=
 =?utf-8?B?MUZhN0x4Ly9pcVQrMW8yVjY0NFllc0ZKOXpIQXFKS0JvZldOR0YvSUo1MzJP?=
 =?utf-8?B?eFJqMlZFd2pFMGdEVFZQenA5M3VpWnBqRXcvVnhXY1R3ZXVmcWlsQ2JHWStr?=
 =?utf-8?B?RU5DNGE0MldhaW5mZGhDaCs2cFRUWjFCK2ZNbFNYSUl0bTdWcE1IZERLOHk2?=
 =?utf-8?B?ZkJsZ0t5SWp5SVA4alAvemRjbHNvamF0RU5NVllKbVpDUjN5NUpPTkNNcDdk?=
 =?utf-8?B?UFBqNU52WnVkQmRqaVpWeVFZanc5NW04SWQ5Zmt4TkxCMU5UZCtJemYwT1RV?=
 =?utf-8?B?Z0JHTjdYcTFRWE0ySE9DQ3dUN0RYdHRySUdhZ1ArT2FBNkhpZEVxdlFJVTRX?=
 =?utf-8?B?Tk41VDZiTG1rNHZHOW9CeVVsKzBJSVYzV3BYZDVEakJOL2VzRjlrL0hGeXRQ?=
 =?utf-8?B?dms1VWNSSFhIcS8rU3VNMXdQV2t1bjVFeFVSang0ZUNhQlFDZGxJS2hLbGF4?=
 =?utf-8?B?Mis1Sk1rZzhvRHovbXVDL2NuV053WkY4R2hONDlVQlZuNnIxTWNFbGIzTFdJ?=
 =?utf-8?B?NVVWam9oMzUwWWgrUHdVZ0swRjFwMzFhUS9Ua0N2cFV6QWsyajU0V0JXWGdT?=
 =?utf-8?B?VWdUQTRnLzYzazluY0FrZjBkN2tpeUhEK2JnTjZRb0dwNGJROU5UMnFnNFZq?=
 =?utf-8?B?S1dXQlNqeVhLY3dWSThSOHIwM3pPaEJ5cmpib3Z4TGtUSUJTSHdZOStKNk4x?=
 =?utf-8?B?dWlONFh3TDBTLzI3RWFlcVYwWW51SzRDTlZqZFdjMFdGSjdJWmRsakFyeXkw?=
 =?utf-8?B?aE4yYzg1MTA2R2tMM2kyUlA3TmFrMGxTUDZlK0VZbDBWSEJIbG5lc2VtMmRq?=
 =?utf-8?B?dEl3YlgwOStrOE5mZE9GZjlrbUkzMjRFVnZiSkE0VjRnSFROY2dQZExUYmdV?=
 =?utf-8?B?OXQ1dGZRaFkxSGJQSzc1ZDJ6Y1I3bVlPcFJSSHRtUDZSS0VtVlpKR2k5Q0dr?=
 =?utf-8?B?WUlXdzhWUjJwSC9sMkF5ZXRISDBwM0V6VFRDeS9COEVVT1lUb1poOGFPMk15?=
 =?utf-8?B?bjZMcFQ0bXNkZjl0dU9CemcxRmZMR0x4SzhwRytKSEdDVjFYM2tqTklmWXBw?=
 =?utf-8?B?cWVEMjljaXJMRStNVnNDdFFZZ1lDMU96NkxGSk9VK0hBd1JWdG83ZWdhK2tK?=
 =?utf-8?B?NTA4d1lLWVRKR01hSFZnb2NXNEVoS2pTMzgrVnJHWkxGNWNKV0tvNXk3VUVW?=
 =?utf-8?B?VFJrenltVG5kRTAvT0ZOYlBUTllmQVhHd0RjTGtVbGJOSzNmQ0dmTmhZWldm?=
 =?utf-8?B?VmMvSm5HTW1jQWtWNXplb3FGN1ZESkFITW1SQXVBbnRoWnRmV1JtWGdrSjVO?=
 =?utf-8?B?R1U4Q3VlVzhqSW9pdlhzQU5mTGtLYUIxNWxLWDc1RVdoU0dKakVoR1FCUzJr?=
 =?utf-8?B?S09yd0ErY0xxeFFUSmJVaFloQVZ0cnV6WFdYQkk4WUZ5L1AyaUdTOXgyL3Rs?=
 =?utf-8?B?S20ra0NzVkJyeGNDYTNsaFE5T0R2K2FQV0hlRElqaCtXTEhiRktsWjF0bUJy?=
 =?utf-8?B?V3ljSmswbS8rb2xFUUExNm1nZFd3UGFUNk51YW5UaDdrNGNvN1JhdU5mbVdQ?=
 =?utf-8?B?eUhxa0QrQ2I5Ulc2dFEvM1VLd1UwU1NwbHVZSFNjOWQvUzdXd3QvSkc1dXNO?=
 =?utf-8?B?ZEVndElIaXlyTm9QUFl4ZUlkUEJGbU81WHNhc2haL29IZzBJSG1RUFErOVlF?=
 =?utf-8?B?ODYxd2ExdlFETkdlK29RV1pybmhGNmR2NXJwUzdwbXREL3hvVFIwbG5rai81?=
 =?utf-8?B?NkkvV2tHMFQyamVEOFdUSEQxeG96d1JNV2lQeGU0RnJQUG4wMlN6WWsrSTZu?=
 =?utf-8?B?RVFaWHZmelRqMzJqaCtzZlBWaEQ0ODM1b1dxcFhzRkRMN21xYWNOaUVaS2JV?=
 =?utf-8?B?WXZ4NWxET3lHY3c1NlYxZWw5aGpSYXJyT05maHlpRnlUdnJhYXVuYWNSVUVO?=
 =?utf-8?B?eHp2UlpjdTNzeWpmM3Z4eGdSTmlRRE03bzE0M2Ryem9TTlcrdDdUVXFJL0d3?=
 =?utf-8?B?amNjZDdKT05QbndxNEFxaE1LMXQyNFVGOEtjb0IvV1QyQkhwZDhLakZORmRO?=
 =?utf-8?B?WGQzenQxK2xEbU4yNVJjQWszU2NYNDYvWEk0R1paTWNKMU1iR3NKR2oyN3ZR?=
 =?utf-8?B?dUxxNjdlVFM5aEprN2ljdmh0aDYwY2dRbktKdGJpTGdOSlhZaEZaWENXOC84?=
 =?utf-8?B?MFVXQWs5ZVhzaXR5M1VwQXlDZzNyMkpMdVBrSm85a05VanJpUFNscjBuelZ0?=
 =?utf-8?B?MVJlRndXaGVmTXVlU0NaM09sTld2NUxJZjE5Q3FGK3JZdWVLbTR6QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1771fa-08fc-4dc6-f0c5-08deaa1671c0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 19:50:50.9672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yr7V9MqfyxKqbsFwFlbEmhtwBpnXxU7nNjTTAYFkXNmk1xglrtgjYa0QPeHtuhzD3Szg7DTOnx2f/Sgz5gcpSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9000
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



On 5/4/2026 3:42 PM, Danilo Krummrich wrote:
> On Mon May 4, 2026 at 9:28 PM CEST, Joel Fernandes wrote:
>> We are already at v12 now
> 
> To be fair, the series is actually at v6, as you initially added those patches
> to another series that was at v6 already back then, and then you decided to just
> keep going with it. So, nothing too crazy going on that front. :-)

I was thinking of resetting it to v1 and starting by breaking it up and
starting over from what's left instead of a v13. I think at this point,
probably breaking it down into multiple series with new version numbers
makes sense. And I can point to the old patch series that way for reference.

Could you clarify how much time we have left to submit to drm-rust-next? I
can then plan the next series accordingly. I did make some changes to GpuMm
to be more suitable for channels, but haven't posted them yet.
