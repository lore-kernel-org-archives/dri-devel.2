Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E7E109B469
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A677410E8FF;
	Tue, 31 Mar 2026 13:47:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="lKVniZaf";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0342010E8FF
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 13:47:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suhdj62U8pxHcGrPI1CbMuQ+G1UIXyvNbWs8xrD3UoKFRGYam4Bp2O3HWKqEV4undKNRXSeipqYE4SYp1UFvWz2DWJ5m3aHOy5h/FTNqkMsDu7BVXBEIevGSBOcgBcWII3B+vz3P6YR6rRP+k2COZMm4iqr05HcMJrUzr0+57yn8lf5xF68F1C7BvSMzvGsdoP7jsOaHAVSTjzkCxH/Em9OLYimcuWd33GGJdrFVS21e6NwdKyA5fhxYfPaXE9PAVB0NLmjOVEZEYekHZhk0DY4V+Gebobz0L1ssbI7EDv+5ZX6F49XG6ojar/nH0U0rvDXJUVOdFrDKfdoYKZV40w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEAgVfuEf77eDGbOTqRTVmt8aN2sMBhVz6jxe6wQ0k8=;
 b=QnkNoi3sj2Tx8JrsWizO8zV9QslPG30bP2Dh2XB5MzUe95yBTuPM2T1uDrdCW+ElLqIStGMStOUgn8d9Y8D8PaGQcNfTxPJ5+UBcxyUFHZrhDV/QOdGWE3dwLP3O4ZQJ4r1BhNo497/7SngugtqWQj3a9OuS9KHXzT1VzklfIis8K4Pf42yjgwMrQcs5JflcXnwh1QZeyXOfUb2EQRSM4hGEWX68qJPitr6/bomKMVWAcoBLgYJ9gDtwV1FoarJxQ+MMzx8x4FOUYF2ikwzTZhmT/Tfz2xnze3ugvvztS7XXqs2XLAnTnsRo6oWFNXis40kgqtSMCdjK3qlj/ctMhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEAgVfuEf77eDGbOTqRTVmt8aN2sMBhVz6jxe6wQ0k8=;
 b=lKVniZafbpjUAAzPA6QFS+bOzPPYThXmpG2w1Bk5MB4Fhib5RXHBhJtp8OIli7UA/x/LB/0+XvRHY5XJcL0wzIH87j9yw8F7NF+9dvQ5ITObkEjwdtzarn+Uo3q7lukaELgP+mstGrZqxk4LQT/71o1fwy7oO81/76BUT+GhYmGVbsEF0ChJ8rmeiFGZvFyk9KvSdvIE4TlCwFn7Qs21nlt2vnjYoEFUJAY9lCdIp6Bg3PhFg8kg8jb80U/gIBfVWPdyOa3rVAOUZHBelZpmhnV6WhAt1ZUqg3PgGz6cUjX6eUgi9CpXoVqu0XefjVehETLLA2l6xFs5m1Y662ZqpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB6308.namprd12.prod.outlook.com (2603:10b6:208:3e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 13:47:31 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 13:47:31 +0000
Message-ID: <c892904c-fea5-4a39-ab3b-e3c4bab9ba75@nvidia.com>
Date: Tue, 31 Mar 2026 09:47:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu: nova-core: bitfield: fix broken Default
 implementation
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260331-fix-bitfield-v1-1-ebe1a72b4fae@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260331-fix-bitfield-v1-1-ebe1a72b4fae@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR13CA0015.namprd13.prod.outlook.com (2603:10b6:930::24)
 To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: 125c52be-9702-4d30-ed02-08de8f2c0e16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: lNt05hcjyMP9aU6jwf4qvLHeJev14atrlhdFZmC8zVzPuu98P+wSIGdbsDSq+s6oCDp54StTKX2IVQSmrs7JfBB9fHYnBw2BSgkDEzgHw0/1540MpKOxhKRopHBP/UMFQfggltIOOfubvc2zr0ClWhVma1LpdqH6hUdLrAmi1QmnKSIGZ+tJ5mFyJlhVZw7XOPG3dhtKrT++22kbPtR+bjROFYjFWnuwx50FdTWswXRdAV0kYLkCSdMkiaX7ncGTaOaEoz3VJ/ko9t4Tkg9drKHMOQUriZMBf7vdkCb0NYwil3OVDbcVmtj5IGLarCG2cnQFBXKPsax0eHGhkTVVH2MEkoOMhziFamlXvlEsR5o3YVZT5zCC9JM0dS2NkC8A2eErOSd7CoJ9uKQI5vINbjqFAFOczA9+Up0HzqSC6e2qePncSmiIE3RTb8yc4L3LxxDYnniigaSjmoa5KQCzEUngI3nP8bVrl4K6I6bTfGfnz+Py8ni9vjqN6/Gls5HPe0S9958oF3i9fF0TGGlqBn9XHrmXbrXCX1YUE/rGWeQWp50yM9mCfDxumNBBAhRtI8FoWM8ekXjpp13IWKHUdMWTkzV7nf5AKPJuhRnfCqYSuUwCARCr+lzhtuxjrIzz2+b3mROnZ2StbCV6KR4q+gZeTUZ0MjrTv2tAnyqZ6QzfmzKkdh6YNTWFROIvffLOydKB9tMUY/sd6kcWAyddy4yBuon9O5QatOKboLbI29A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TllFUFFsSGVUQ3RkZmk2OE4rQWdMeFRseTF6bzRCRTkvcWtySXJGeXRWUllp?=
 =?utf-8?B?OERyRzhObHR6UHZsQXkwakFFY2U0Ry9QK0p2dmJJN1NlT1FoSXV1UTU4UlRD?=
 =?utf-8?B?L0ZiZDFEd3N0b1ZaWHVwT1FSeVdEYURNNDlveHZ0WlhmQm1XWXdCRWpwVnIz?=
 =?utf-8?B?NUE1QTdramdNaTJ5Rkh2ci82VTNnVlZRY3VSZGtQMXluMWRORm4xWGdjQ0NT?=
 =?utf-8?B?bTAycktOOVJGNkhRUlRNaEU5SGk0VEZNWlpYa3RvYSs3cHo1eE9waFg0dFJ6?=
 =?utf-8?B?QmNBZ2hEdmgzUDFoK2Q4ejZoY3lBWEl5V3VNdlpJdFZvQzBvOUN1WlFZLzJQ?=
 =?utf-8?B?VGlrSXB6WjcwNkhKR1k4dGROVVJaZGRTYkhqbGVQT29IcTUrc3laUWlTR00x?=
 =?utf-8?B?QUhVYnMwakp3NHd0aWVTMGRESWRvK2lZNlRQUWtPaGVYNjYvRHNjeFlIWFBQ?=
 =?utf-8?B?bjhQZzF2OE5XNzFKTytyMGNqc2lUQ1JNdzE0dmV4STJtMXhmekZQZ25lYW0r?=
 =?utf-8?B?cGJ0WFUwTWx5UEtVQW1sZ1hLSHJLa1JZNnVEdEhpZkQvR1dFbS8wNzRzU3BT?=
 =?utf-8?B?KzlhZlFLdkRzMVo3ZldFaFBpcnl4WlRqRXpiU3NyOFVMVm1NdDRpRXZjek4z?=
 =?utf-8?B?Uk5tb1c5SWxTTnNCejc2eURUSWVheU8rVjBLS013cEk3OXFDL1VINENLMUh2?=
 =?utf-8?B?QnVueGl2U0M3Tk5VbTN3SXlsbEJQQU9ZYWRFeThENUFERkVnRnJQcEVScThW?=
 =?utf-8?B?d2FaZkk0Wm9pL1BKbzF4VllQSHcwTXFQb3Fwa0c2MzBqU2NVYU90anZJa0gw?=
 =?utf-8?B?ZjROK3JVemFNdUx1dURwdXNvdDY4WUhjVk1xczN1NmxwYWxlSEhLWmw4TkFS?=
 =?utf-8?B?YVFILzRDTjhHMXRVZVNKb2E0MzVMT3Z5R0tMQVI1dWVvcFNCQ3FXbE0xU3gw?=
 =?utf-8?B?QWN1eWlPbE05S0dJSi95dXJrTG4rWFoxaHc2ZlUrUWlhcnNBdDhxTjFuaFcw?=
 =?utf-8?B?NlBWOVlaT3gvNTlsUUNsY1JEM0d6czRjRlhsR0hkOWVqbzhHd3dhOGY1Y3R6?=
 =?utf-8?B?UkVmc1BrMFd6b2RhSGVwcnZzZFVEcE1HRytRd0xEU0FjLzljbTBvenR4UDU3?=
 =?utf-8?B?Slc2Rk8xSG04RW0yaGRoSWxPeUEvOWdZSGhjaFhzenU1emU1QVlqNldZMFg5?=
 =?utf-8?B?Vjk3WnJFSkllNFhoQW9Xb0xObDFEZ2FTVEJHd2wwVzBDdDUzMzUzNU9xYTRp?=
 =?utf-8?B?T2JZNEtLczJjMXpxYXZ4WlU5N1dlSXVkSnE0MUExYXFUZjg0TXFxTXhDWVNo?=
 =?utf-8?B?QzVicCtoRkhqMFZsZnFDbTVJRDZTYThYZ3BUaXVZZnFiWWQ0YnREU1RINVMx?=
 =?utf-8?B?aDlGNCtzcDR0clJ3RWdXa1lPSjdVMFRPNDhZRnRWUmlHS0FuSU54akdPVE9m?=
 =?utf-8?B?azFYZmdVMFgrQXlCQ3NFNXhPdHl5T3hjdDhWbkYzSFNjbWpKSGh5cDNnM1VE?=
 =?utf-8?B?VHlZc0JhajZFOG96ZENuVS9pRElTZWlrcDFMUWxxTmF1VEY0U2tBbFBZQXZS?=
 =?utf-8?B?SzRQM2VuT0JRTlA0NjJLTkZHYUxxZDE4OTNmQ0JXeTUvVmw3S3RPTTVXd2ds?=
 =?utf-8?B?UUNPU0JjbzE0ckdFMmMyNnEvY2hyVzRGdTdGOHEwVnVvaXBhZlhxelVMVlg0?=
 =?utf-8?B?N2hPajlOaDl6aFJVUWV0LzdJS3pPdithQWZYSHU4WThqSENXWUJ4bWYzRjF3?=
 =?utf-8?B?UkZxbExIMG13WXZtelF0OWtQSnpQbDZJUktrQ2pQc1F3eklvVmJBR0NOTmFR?=
 =?utf-8?B?a1dhRzlySkJQb2NNcDdZT1J0b1hkZnRtQmhXOHhLYjJvNHlGdWIxb0gxTjdL?=
 =?utf-8?B?bXM1SFZrc08yWnpWTmtaRHVGNUd1QVcwbTUwd2xQVHVCODkrUXBzRVYrZm9I?=
 =?utf-8?B?QUJTbG5haW0rZm5SaHlXSENhYktJejZSRE81MzZjTjQwRGF0N2pmSFdvL2d4?=
 =?utf-8?B?Y3dsUGJDN0FVNjRXMUlUOXpOWU92aHZ2REtqOXdHakJ6VmE0WitQY1ZXYUZi?=
 =?utf-8?B?bWFpUDBMRVRWbVNGSDRtaXRHMWlsbWs4V0FVVng4eFpONG9Sc2FrVGl2Y2pr?=
 =?utf-8?B?eWY3bVFtRmtrZENIOGhRUVA3WmJqWHZocU9XbHNlUjVzVFZBS2svUjVUQXRL?=
 =?utf-8?B?a3JzUUY2YzlpRVpXRGZSWTlhVDVIVk9jWFN2UndCMHREbG8vK1hYemVJR1Nu?=
 =?utf-8?B?UVdEbzBVNUFXM05jeHV1T3ZlWmJnZ0xEN2VEMEdhVVpqeDdmbVdHVWlPK0ln?=
 =?utf-8?B?b0ZoVFVXT2FsQ3Z1aDJpZzZXNjBsUC9MZHI3ZDF4TlNlNUtZUCt6Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 125c52be-9702-4d30-ed02-08de8f2c0e16
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 13:47:31.2949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wBcl1nBkF5760GeqDEMiQuyG5ijscvsCV62lhU1VQeZnjpkXNPLZoDgQn+CBpsZHEtNN3wnf1aT//JdQRjx0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6308
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



On 3/31/2026 3:56 AM, Eliot Courtney wrote:
> The current implementation does not actually set the default values for
> the fields in the bitfield. Set it and add a test.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

thanks,

--
Joel Fernandes


> ---
> It doesn't actually set the default values for each field. I know that
> bitfields are being moved soon, so maybe this fix is unnecessary but I
> saw it and it's a simple fix.
> ---
>  drivers/gpu/nova-core/bitfield.rs | 50 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 47 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/bitfield.rs b/drivers/gpu/nova-core/bitfield.rs
> index 16e143658c51..22d68fc21a1f 100644
> --- a/drivers/gpu/nova-core/bitfield.rs
> +++ b/drivers/gpu/nova-core/bitfield.rs
> @@ -4,6 +4,8 @@
>  //!
>  //! Support for defining bitfields in Rust structures. Also used by the [`register!`] macro.
>  
> +use kernel::prelude::*;
> +
>  /// Defines a struct with accessors to access bits within an inner unsigned integer.
>  ///
>  /// # Syntax
> @@ -314,12 +316,11 @@ fn fmt(&self, f: &mut ::kernel::fmt::Formatter<'_>) -> ::kernel::fmt::Result {
>          /// Returns a value for the bitfield where all fields are set to their default value.
>          impl ::core::default::Default for $name {
>              fn default() -> Self {
> -                #[allow(unused_mut)]
> -                let mut value = Self(Default::default());
> +                let value = Self(Default::default());
>  
>                  ::kernel::macros::paste!(
>                  $(
> -                value.[<set_ $field>](Default::default());
> +                let value = value.[<set_ $field>](Default::default());
>                  )*
>                  );
>  
> @@ -328,3 +329,46 @@ fn default() -> Self {
>          }
>      };
>  }
> +
> +#[kunit_tests(nova_core_bitfield)]
> +mod tests {
> +    use super::*;
> +
> +    #[derive(Debug, Clone, Copy, Default, PartialEq, Eq)]
> +    enum State {
> +        Inactive = 0,
> +        #[default]
> +        Active = 1,
> +    }
> +
> +    impl From<bool> for State {
> +        fn from(value: bool) -> Self {
> +            if value {
> +                State::Active
> +            } else {
> +                State::Inactive
> +            }
> +        }
> +    }
> +
> +    impl From<State> for bool {
> +        fn from(state: State) -> bool {
> +            match state {
> +                State::Inactive => false,
> +                State::Active => true,
> +            }
> +        }
> +    }
> +
> +    bitfield! {
> +        struct TestBitfield(u32) {
> +            0:0 state as bool => State;
> +        }
> +    }
> +
> +    #[test]
> +    fn default_impl() -> Result {
> +        assert_eq!(TestBitfield::default().state(), State::Active);
> +        Ok(())
> +    }
> +}
> 
> ---
> base-commit: 7c50d748b4a635bc39802ea3f6b120e66b1b9067
> change-id: 20260331-fix-bitfield-a03f6d1b9e00
> 
> Best regards,
> --  
> Eliot Courtney <ecourtney@nvidia.com>
> 

